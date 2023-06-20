/// <summary>
/// Codeunit Employee Marking Mgt._LDR (ID 50009)
/// </summary>
codeunit 50009 "Employee Marking Mgt._LDR"
{
    trigger OnRun()
    begin
        LoadFiles;
    end;

    var
        "Employee Marking Entries": Record "Employee Marking Entries_LDR";
        absiteFile: File;
        instr: InStream;
        TempTxt1: Text[1024];
        FileList: Record "File";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        FileCounter: Integer;
        "Human Resources Setup": Record "Human Resources Setup";
        Text001: Label 'There isn''t any file to process';
        Text002: Label 'It has been loaded % Files';
        Text003: Label 'There is no Service Item with Vehicle Refill Id %1';
        Text004: Label 'There is no Serv. Item Counter with Terminal Code %1 for Serv. Item No. %2';

    /// <summary>
    /// LoadFiles()
    /// </summary>
    procedure LoadFiles()
    var
        FilePath: Text;
        counter: Integer;
    begin
        //FUNCION CARGAR FICHEROS
        "Human Resources Setup".GET;
        CLEAR(FileList);
        FileList.SETRANGE(Path, "Human Resources Setup"."Route File Marking_LDR");
        FileList.SETRANGE("Is a file", TRUE);
        FileList.SETFILTER(Name, '%1', '*.*'); //CAS-20209-B2J6 - Modificamos el filtro, porque ahora los archivos tienen extension , antes era <>%1
        IF FileList.FINDSET THEN BEGIN
            REPEAT
                FilePath := FileList.Path + '\' + FileList.Name;
                LoadSingleFile(FilePath, FileList.Name);
            UNTIL FileList.NEXT = 0;
            MESSAGE(Text002, FileCounter);
        END ELSE
            MESSAGE(Text001);
    end;

    /// <summary>
    /// LoadSingleFile()
    /// </summary>
    local procedure LoadSingleFile(FilePath: Text; FileName: Text)
    var
        vString: Text;
        PosCode: Integer;
        TransactionType: Text;
        RefillType: Text;
        Bulk: Text;
        i: Integer;
        LastCounter: Decimal;
        NextCounter: Decimal;
        CounterType: Text;
        Employee: Record "Employee";
    begin
        absiteFile.TEXTMODE(TRUE);
        absiteFile.WRITEMODE(FALSE);
        absiteFile.OPEN(FilePath);
        REPEAT
            absiteFile.READ(vString); //Se guarda en la variable vString el contenido del fichero
                                      //Se obtiene de las posiciones indicadas los valores.
            WHILE STRLEN(vString) > 0 DO BEGIN
                CLEAR("Employee Marking Entries");
                //MESSAGE('Primera parte: '+COPYSTR(vString,1,38));
                IF COPYSTR(vString, 1, 1) IN ['H', 'I'] THEN BEGIN

                    IF COPYSTR(vString, 1, 1) = 'H' THEN
                        "Employee Marking Entries"."Entry Type" := "Employee Marking Entries"."Entry Type"::Entrance
                    ELSE
                        IF COPYSTR(vString, 1, 1) = 'I' THEN
                            "Employee Marking Entries"."Entry Type" := "Employee Marking Entries"."Entry Type"::Departure;

                    "Employee Marking Entries"."Entry Date" := GetFormatDate(COPYSTR(FileName, 1, 8));
                    "Employee Marking Entries"."Entry Time" := GetFormatTime(COPYSTR(vString, 2, 6));
                    "Employee Marking Entries"."Door Operation Code" := COPYSTR(vString, 8, 2);
                    "Employee Marking Entries"."No Operation Card" := COPYSTR(vString, 10, 4);

                    CLEAR(Employee);
                    Employee.SETRANGE("Tag Card No.", "Employee Marking Entries"."No Operation Card");
                    IF Employee.FINDFIRST THEN BEGIN
                        //Encontrar el empleado que es para almacenar sus valores

                        "Employee Marking Entries"."Operation Employee Code" := Employee."No.";
                        "Employee Marking Entries"."Operation Resource Code" := Employee."Resource No.";
                        "Employee Marking Entries".INSERT(TRUE);
                    END;
                END;
                vString := DELSTR(vString, 1, 38);
            END;

        UNTIL absiteFile.POS = absiteFile.LEN;

        absiteFile.CLOSE;
        FileCounter += 1;
        //Mover ficheros y borrar
        COPY(FilePath, "Human Resources Setup"."Route File Marking Backup_LDR" + '\' + FileName + '.000');
        ERASE(FilePath);
    end;

    /// <summary>
    /// GetFormatDate()
    /// </summary>
    local procedure GetFormatDate(Value: Text): Date
    var
        MyTextDate: Text;
        MyDate: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        EVALUATE(Year, COPYSTR(Value, 1, 4));
        EVALUATE(Month, COPYSTR(Value, 5, 2));
        EVALUATE(Day, COPYSTR(Value, 7, 2));

        MyDate := DMY2DATE(Day, Month, Year);
        EXIT(MyDate);
    end;

    /// <summary>
    /// GetFormatTime()
    /// </summary>
    local procedure GetFormatTime(String: Text) Time: Time
    var
        datetime: Time;
    begin
        EVALUATE(datetime, String);
        EXIT(datetime);
    end;

    /// <summary>
    /// GetFormatInt()
    /// </summary>
    local procedure GetFormatInt(String: Text) "integer": Integer
    var
        Integerout: Integer;
    begin
        EVALUATE(Integerout, String);
        EXIT(Integerout);
    end;

    /// <summary>
    /// GetFormatDec()
    /// </summary>
    local procedure GetFormatDec(String: Text) decimal: Decimal
    var
        Decimalout: Decimal;
    begin
        EVALUATE(Decimalout, String);
        EXIT(Decimalout);
    end;
}