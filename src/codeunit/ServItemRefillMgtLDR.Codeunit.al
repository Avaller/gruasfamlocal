/// <summary>
/// Codeunit Serv. Item Refill Mgt._LDR (ID 50003)
/// </summary>
codeunit 50003 "Serv. Item Refill Mgt._LDR"
{
    trigger OnRun()
    begin
        LoadFiles;
    end;

    var
        ServiceItemRefillsReg: Record "Service Item Refills Reg_LDR";
        absiteFile: File;
        instr: InStream;
        TempTxt1: Text[1024];
        FileList: Record "File";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        Text001: Label 'There isn''t any file to process';
        Text002: Label 'It has been loaded % Files';
        FileCounter: Integer;
        Text003: Label 'There is no Service Item with Vehicle Refill Id %1';
        Text004: Label 'There is no Serv. Item Counter with Terminal Code %1 for Serv. Item No. %2';
        CraneSetup: Record "Crane Mgt. Setup_LDR";
        Text005: Label 'Refill Entry Counter''s Value must be greater than the Actual H/Km in Serv. Item''s counter.';

    /// <summary>
    /// LoadFiles()
    /// </summary>
    procedure LoadFiles()
    var
        FilePath: Text;
        counter: Integer;
    begin
        //FUNCION CARGAR FICHEROS
        CraneSetup.GET;
        CLEAR(FileList);
        FileList.SETRANGE(Path, CraneSetup."Route File Refills");
        FileList.SETRANGE("Is a file", TRUE);
        FileList.SETFILTER(Name, '%1|%2', '*.MLG', '*.mlg');
        IF FileList.FINDSET THEN BEGIN
            REPEAT
                FilePath := FileList.Path + '\' + FileList.Name;
                LoadSingleFile2(FilePath);
            UNTIL FileList.NEXT = 0;
            MESSAGE(Text002, FileCounter);
        END ELSE
            MESSAGE(Text001);
    end;

    /// <summary>
    /// LoadSingleFile2()
    /// </summary>
    local procedure LoadSingleFile2(FileName: Text)
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
    begin
        absiteFile.TEXTMODE(TRUE);
        absiteFile.WRITEMODE(FALSE);
        absiteFile.OPEN(FileName);
        REPEAT
            CLEAR(ServiceItemRefillsReg);
            absiteFile.READ(vString);
            PosCode := STRPOS(vString, ';');
            TransactionType := FORMAT(COPYSTR(vString, 1, PosCode - 1));
            vString := DELSTR(vString, 1, PosCode);
            PosCode := STRPOS(vString, ';');
            IF TransactionType = '01' THEN BEGIN
                //solo procesar transacciones de tipo 01
                ServiceItemRefillsReg."Transaction Type" := TransactionType;

                //Leo en una variable Bulk los campos que no me interesan
                FOR i := 1 TO 2 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Transaction Code" := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                ServiceItemRefillsReg."Terminal Code" := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                //Leo en una variable Bulk los campos que no me interesan
                FOR i := 1 TO 3 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Transaction Date" := GetFormatDate(FORMAT(COPYSTR(vString, 1, PosCode - 1)));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                ServiceItemRefillsReg."Transaction Time" := GetFormatTime(FORMAT(COPYSTR(vString, 1, PosCode - 1)));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                //Leo en una variable Bulk los campos que no me interesan
                FOR i := 1 TO 2 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Refill Type" := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                //Leo en una variable Bulk los campos que no me interesan
                FOR i := 1 TO 2 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Vehicle No" := DELCHR(FORMAT(COPYSTR(vString, 1, PosCode - 1)), '<', '0');
                ServiceItemRefillsReg."Service Item Code" := GetServItemNoFromPlannerNo(ServiceItemRefillsReg."Vehicle No");
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                FOR i := 1 TO 9 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Driver No." := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                FOR i := 1 TO 6 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                LastCounter := GetFormatDec(FORMAT(COPYSTR(vString, 1, PosCode - 1)));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');
                NextCounter := GetFormatDec(FORMAT(COPYSTR(vString, 1, PosCode - 1)));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                CounterType := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');
                IF (CounterType = 'H') THEN BEGIN
                    ServiceItemRefillsReg."Before Value" := LastCounter / 10;
                    ServiceItemRefillsReg."Actual Value" := NextCounter / 10;
                    ServiceItemRefillsReg."Cont Type" := 1;
                END ELSE BEGIN
                    ServiceItemRefillsReg."Before Value" := LastCounter;
                    ServiceItemRefillsReg."Actual Value" := NextCounter;
                    ServiceItemRefillsReg."Cont Type" := 2;
                END;

                FOR i := 1 TO 2 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Item Type" := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                FOR i := 1 TO 2 DO BEGIN
                    Bulk := FORMAT(COPYSTR(vString, 1, PosCode - 1));
                    vString := DELSTR(vString, 1, PosCode);
                    PosCode := STRPOS(vString, ';');
                END;

                ServiceItemRefillsReg."Transaction Volume" := GetFormatDec(FORMAT(COPYSTR(vString, 1, PosCode - 1))) / 100;
                vString := DELSTR(vString, 1, PosCode);
                PosCode := STRPOS(vString, ';');

                ServiceItemRefillsReg.INSERT(TRUE);
            END;
            //Tras introducir, borro el resto de la linea
            vString := DELSTR(vString, 1, STRLEN(vString));
        UNTIL absiteFile.POS = absiteFile.LEN;

        absiteFile.CLOSE;
        FileCounter += 1;
        //Mover ficheros y borrar
        COPY(FileName, CraneSetup."Route File Refills Backup" + '\' + FileList.Name);
        ERASE(FileName);
    end;

    /// <summary>
    /// GetFormatDate()
    /// </summary>
    local procedure GetFormatDate(String: Text) date: Date
    var
        dateout: Date;
    begin
        EVALUATE(dateout, String);
        EXIT(dateout);
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
    /// GetServItemNoFromPlannerNo()
    /// </summary>
    local procedure GetServItemNoFromPlannerNo(pPlannerNo: Code[20]): Code[20]
    var
        ServItem: Record "Service Item";
    begin
        CLEAR(ServItem);
        ServItem.SETRANGE("Planner No_LDR", pPlannerNo);
        ServItem.SETRANGE("Out Of Service_LDR", FALSE);
        ServItem.SETFILTER("Cancelation Cause Code_LDR", '%1', '');
        IF ServItem.FINDFIRST THEN;
        EXIT(ServItem."No.");
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

    /// <summary>
    /// ProcessEntries()
    /// </summary>
    procedure ProcessEntries(RefillEntries: Record "Service Item Refills Reg_LDR")
    begin
    end;

    /// <summary>
    /// ProcessSingleEntry()
    /// </summary>
    procedure ProcessSingleEntry(RefillEntry: Record "Service Item Refills Reg_LDR")
    var
        ServItem: Record "Service Item";
        ServItemCounter: Record "Service Item Counter_LDR";
    begin

        IF RefillEntry."Service Item Code" = '' THEN BEGIN
            CLEAR(ServItem);
            ServItem.SETRANGE("Refueling Vehicle ID_LDR", RefillEntry."Vehicle No");
            IF NOT ServItem.FINDFIRST THEN
                ERROR(Text003, RefillEntry."Vehicle No");
        END ELSE
            ServItem.GET(RefillEntry."Service Item Code");

        CLEAR(ServItemCounter);
        ServItemCounter.SETRANGE(Code, ServItem."No.");
        ServItemCounter.SETRANGE("Terminal Code", RefillEntry."Terminal Code");
        IF NOT ServItemCounter.FINDFIRST THEN
            ERROR(Text004, RefillEntry."Terminal Code", ServItem."No.");

        IF ServItemCounter."KM/H Actual" > RefillEntry."Actual Value" THEN
            ERROR(Text005);

        ServItemCounter.VALIDATE("KM/H Actual", RefillEntry."Actual Value");
        //ServItemCounter."KM/H Accumulated" += RefillEntry."Actual Value";
        //ServItemCounter."KM/H Effective" :=  ServItemCounter."KM/H Accumulated" + (RefillEntry."Actual Value"-RefillEntry."Before Value");
        ServItemCounter.MODIFY(TRUE);

        RefillEntry."Service Item Code" := ServItem."No.";
        RefillEntry."Serv. Item Counter No." := ServItemCounter."Counter No.";
        RefillEntry.Process := TRUE;
        RefillEntry.MODIFY(FALSE);
    end;

    /// <summary>
    /// LoadSingleFile()
    /// </summary>
    local procedure LoadSingleFile(FileName: Text)
    var
        text02: Integer;
        text01: Text;
        TransactionType: Text;
        RefillType: Text;
    begin
        //FUNCION DESACTUALIZADA
        //QUEDA AQUI COMO EJEMPLO PARA DESARROLLO


        absiteFile.WRITEMODE := FALSE;
        absiteFile.TEXTMODE := FALSE;
        //Llamada a la funcion para realizar comprobacion de que hay fichero y extraer el nombre.
        absiteFile.OPEN(FileName);
        absiteFile.CREATEINSTREAM(instr);
        instr.READTEXT(TempTxt1, 990);
        //En caso de ser distinto de 01 no se tiene que realizar ninguna accion.
        TransactionType := COPYSTR(TempTxt1, 1, 2);
        RefillType := COPYSTR(TempTxt1, 85, 1);
        //Para poder procesarlo el tipo de echada tiene que ser distinto del valor M y el tipo de transaccion tiene que ser 01
        IF TransactionType = '01' THEN
            IF RefillType <> 'M' THEN BEGIN
                CLEAR(ServiceItemRefillsReg);
                ServiceItemRefillsReg."Transaction Type" := TransactionType;
                ServiceItemRefillsReg."Transaction Code" := COPYSTR(TempTxt1, 21, 4);
                ServiceItemRefillsReg."Terminal Code" := COPYSTR(TempTxt1, 26, 4);
                text01 := COPYSTR(TempTxt1, 60, 10);
                ServiceItemRefillsReg."Transaction Date" := GetFormatDate(text01);
                text01 := COPYSTR(TempTxt1, 71, 5);
                ServiceItemRefillsReg."Transaction Time" := GetFormatTime(text01);
                ServiceItemRefillsReg."Refill Type" := RefillType;
                ServiceItemRefillsReg."Vehicle No" := COPYSTR(TempTxt1, 106, 5);
                ServiceItemRefillsReg."Driver No." := COPYSTR(TempTxt1, 354, 5);
                text01 := COPYSTR(TempTxt1, 581, 6);
                ServiceItemRefillsReg."Before Value" := GetFormatDec(text01);
                text01 := COPYSTR(TempTxt1, 588, 6);
                ServiceItemRefillsReg."Actual Value" := GetFormatDec(text01);
                text01 := COPYSTR(TempTxt1, 595, 1);
                //En caso de que sea H se tiene que dividir el valor actual y el valor de antes entre 10.
                IF (text01 = 'H') THEN BEGIN
                    ServiceItemRefillsReg."Before Value" := ServiceItemRefillsReg."Before Value" / 10;
                    ServiceItemRefillsReg."Actual Value" := ServiceItemRefillsReg."Actual Value" / 10;
                    ServiceItemRefillsReg."Cont Type" := 1;
                END;
                ServiceItemRefillsReg."Cont Type" := 2;
                ServiceItemRefillsReg."Item Type" := COPYSTR(TempTxt1, 628, 2);
                text01 := COPYSTR(TempTxt1, 644, 7);
                ServiceItemRefillsReg."Transaction Volume" := GetFormatInt(text01);
                ServiceItemRefillsReg."Transaction Volume" := ServiceItemRefillsReg."Transaction Volume" / 10;
                ServiceItemRefillsReg.INSERT(TRUE);
            END;
        //Se tiene que cerrar antes de poder borrar.
        absiteFile.CLOSE;
        //Mover ficheros y borrar
        COPY(FileName, CraneSetup."Route File Refills Backup" + '\' + FileList.Name);
        ERASE(FileName);
    end;

    /// <summary>
    /// DistributePendingRefills()
    /// </summary>
    procedure DistributePendingRefills()
    var
        ServiceItemRefillsReg: Record "Service Item Refills Reg_LDR";
        ServiceItemRefillsReg2: Record "Service Item Refills Reg_LDR";
    begin
        WITH ServiceItemRefillsReg DO BEGIN
            SETRANGE(Distributed, FALSE);
            SETRANGE(Process, TRUE);
            IF FINDSET THEN
                REPEAT
                    //BEGIN PCF 29/12/2020
                    //Codigo Antiguo
                    //    IF "Refill Type I/E" = "Refill Type I/E"::External THEN BEGIN
                    //      CLEAR(ServiceItemRefillsReg2);
                    //      ServiceItemRefillsReg2.GET(ServiceItemRefillsReg.RECORDID);
                    //      ServiceItemRefillsReg2.Distributed := TRUE;
                    //      ServiceItemRefillsReg2.MODIFY;
                    //    END ELSE BEGIN
                    //      GenerateGLEntriesForRefill(ServiceItemRefillsReg);
                    //
                    //      CLEAR(ServiceItemRefillsReg2);
                    //      ServiceItemRefillsReg2.GET(ServiceItemRefillsReg.RECORDID);
                    //      ServiceItemRefillsReg2.Distributed := TRUE;
                    //      ServiceItemRefillsReg2.MODIFY;
                    //    END;
                    //  Codigo nuevo
                    //Se elimina el IF para descartar las echadas externas.
                    CLEAR(ServiceItemRefillsReg2);
                    GenerateGLEntriesForRefill(ServiceItemRefillsReg);
                    ServiceItemRefillsReg2.GET(ServiceItemRefillsReg.RECORDID);
                    ServiceItemRefillsReg2.Distributed := TRUE;
                    ServiceItemRefillsReg2.MODIFY;

                //END PCF 29/12/2020
                UNTIL ServiceItemRefillsReg.NEXT = 0;
        END;
    end;

    /// <summary>
    /// GenerateGLEntriesForRefill()
    /// </summary>
    local procedure GenerateGLEntriesForRefill(ServiceItemRefillsReg: Record "Service Item Refills Reg_LDR")
    var
        GenJournalLine: Record "Gen. Journal Line";
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        LineNo: Integer;
        ServiceItem: Record "Service Item";
    begin
        CraneMgtSetup.GET;
        CraneMgtSetup.TESTFIELD("Refuel Gen. Journal Template");
        CraneMgtSetup.TESTFIELD("Refuel Gen. Journal Batch");

        WITH GenJournalLine DO BEGIN
            // Primera Linea
            CLEAR(GenJournalLine);
            GenJournalLine.SETRANGE("Journal Template Name", CraneMgtSetup."Refuel Gen. Journal Template");
            GenJournalLine.SETRANGE("Journal Batch Name", CraneMgtSetup."Refuel Gen. Journal Batch");
            IF GenJournalLine.FINDLAST THEN
                LineNo := GenJournalLine."Line No.";

            LineNo += 10000;

            CLEAR(GenJournalLine);
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name" := CraneMgtSetup."Refuel Gen. Journal Template";
            GenJournalLine."Journal Batch Name" := CraneMgtSetup."Refuel Gen. Journal Batch";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Document No." := 'Refill Reg.';
            GenJournalLine.Description := '';
            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
            GenJournalLine.VALIDATE("Account No.", CraneMgtSetup."Refuel G/L Account");
            GenJournalLine."Posting Date" := ServiceItemRefillsReg."Transaction Date";
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Finance Charge Memo");
            //BEGIN PCF 29/12/2020
            //Codigo viejo
            //GenJournalLine.VALIDATE("Credit Amount", ServiceItemRefillsReg."Transaction Volume" * CraneMgtSetup."Fuel Unit Price");
            //codigo nuevo
            IF ServiceItemRefillsReg."Refill Type I/E" = ServiceItemRefillsReg."Refill Type I/E"::External THEN
                GenJournalLine.VALIDATE("Credit Amount", ServiceItemRefillsReg.Amount)
            ELSE
                GenJournalLine.VALIDATE("Credit Amount", ServiceItemRefillsReg."Transaction Volume" * CraneMgtSetup."Fuel Unit Price");
            //END PCF 29/12/2020
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", 'ALM');

            GenJournalLine.INSERT(TRUE);


            // Segunda Linea
            CLEAR(GenJournalLine);
            LineNo += 10000;

            CLEAR(GenJournalLine);
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name" := CraneMgtSetup."Refuel Gen. Journal Template";
            GenJournalLine."Journal Batch Name" := CraneMgtSetup."Refuel Gen. Journal Batch";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Document No." := 'Refill Reg.';
            GenJournalLine.Description := '';
            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
            GenJournalLine.VALIDATE("Account No.", CraneMgtSetup."Refuel G/L Account");
            GenJournalLine."Posting Date" := ServiceItemRefillsReg."Transaction Date";
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::"Finance Charge Memo");
            //BEGIN PCF 29/12/2020
            //Codigo viejo
            //GenJournalLine.VALIDATE("Debit Amount", ServiceItemRefillsReg."Transaction Volume" * CraneMgtSetup."Fuel Unit Price");
            //codigo nuevo
            IF ServiceItemRefillsReg."Refill Type I/E" = ServiceItemRefillsReg."Refill Type I/E"::External THEN
                GenJournalLine.VALIDATE("Debit Amount", ServiceItemRefillsReg.Amount)
            ELSE
                GenJournalLine.VALIDATE("Debit Amount", ServiceItemRefillsReg."Transaction Volume" * CraneMgtSetup."Fuel Unit Price");
            //END PCF 29/12/2020
            ServiceItem.GET(ServiceItemRefillsReg."Service Item Code");
            GenJournalLine.CreateDim(DATABASE::"Service Item", ServiceItem."No.", 0, '', 0, '', 0, '', 0, '');

            GenJournalLine.INSERT(TRUE);
        END;
    end;
}