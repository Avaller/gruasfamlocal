/// <summary>
/// Codeunit Ingestrel Mgt._LDR (ID 50002)
/// </summary>
codeunit 50002 "Ingestrel Mgt._LDR"
{
    // JLPINEIRO
    // Se tiene que descargar desde la pagina web https://dev.mysql.com/downloads/connector/net/  el fichero de comunicaciones MySQL version 8.0.23.0 para poder compilar los ficheros ya que al tener 3 DotNET
    // que necesitan esa libreria es necesario instalarla en nuestro equipo.
    // 
    // Para la parte de procesado de ficheros es necesario instalar NcFTP 3.2.5 indicando en la carpeta de instalacion la siguiente ruta: “C:\Archivos de programa\NcFTP”.

    /*
    trigger OnRun()
    begin
        //Llamada a la funcion general
        IngestrelSetup.GET;
        General;
        //Llamada a la funcion encargada de procesar los ficheros
        SendFTP;
        MESSAGE(Endms);
    end;

    var
        Conexion2MySql: DotNet MySqlConnection; //TODO: Error: No existe el Dotnet MySqlConnection
        Command2MySql: DotNet MySqlCommand; //TODO: Error: No existe el Dotnet MySqlCommand
        Reader: DotNet MySqlDataReader; //TODO: Error: No existe el Dotnet MySqlDataReader
        Resultado: Integer;
        Contador: Integer;
        IngestrelSetup: Record "Ingestrel Setup_LDR";
        errorCon: Label 'Connection error';
        Company: Record "Company";
        Customer: Record "Customer";
        QueryIns: Text;
        QueryDel: Text;
        Employee: Record "Employee";
        Manufacturer: Record "Manufacturer";
        ServiceItem: Record "Service Item";
        ServiceItemModel: Record "Service Item Model_LDR";
        dlg: Dialog;
        CompanyProcess: Label 'Processing Companies:';
        CustomerProcess: Label 'Processing Customer:';
        EmployedProcess: Label 'Processing Employees:';
        ManufactureProcess: Label 'Processing Manufacturer:';
        ServiceItemProcess: Label 'Processing Service Item:';
        ServiceItemModelProcess: Label 'Processing Service Item Model:';
        CustomerSincro: Label 'Synchronize Customer Files:';
        EmployedSincro: Label 'Synchronize Employed Files:';
        ServiceItemSincro: Label 'Synchronize Service Item Files:';
        absiteFile: File;
        RecordLink: Record "Record Link";
        FileManagement: Codeunit "File Management";
        ServerFileName: Text;
        Customer2: Record "Customer";
        Endms: Label 'End Process';
        Employee2: Record "Employee";
        Manufacturer2: Record "Manufacturer";
        ServiceItem2: Record "Service Item";

    /// <summary>
    /// UpdateParentElement()
    /// </summary>
    procedure UpdateParentElement(recID: RecordID)
    var
        Cust: Record "Customer";
        Emp: Record "Employee";
        ServItem: Record "Service Item";
        recRef: RecordRef;
    begin

        CASE recID.TABLENO OF
            DATABASE::Customer:
                BEGIN
                    recRef := recID.GETRECORD;
                    Cust.SETPOSITION(recRef.GETPOSITION);
                    Cust.GET(Cust."No.");
                    Cust."Ingestrel Export Date" := 0D;
                    Cust.MODIFY(TRUE);
                END;
            DATABASE::Employee:
                BEGIN
                    recRef := recID.GETRECORD;
                    Emp.SETPOSITION(recRef.GETPOSITION);
                    Emp.GET(Emp."No.");
                    //Emp."Ingestrel Export Date" := 0D;
                    Emp.MODIFY(TRUE);
                END;
            DATABASE::"Service Item":
                BEGIN
                    recRef := recID.GETRECORD;
                    ServItem.SETPOSITION(recRef.GETPOSITION);
                    ServItem.GET(ServItem."No.");
                    //ServItem."Ingestrel Export Date" := 0D;
                    Cust.MODIFY(TRUE);
                END;
        END;
    end;

    /// <summary>
    /// General()
    /// </summary>
    local procedure General()
    var
        Company: Record "Company";
        CompanyInformation: Record "Company Information";
        Customer: Record "Customer";
    begin
        //Inicializar Query para que no de fallo por si no contiene ningun dato a la hora de ejecutarla.
        QueryIns := 'SELECT * FROM ' + 'empresas;';
        IF OpenConex() THEN BEGIN
            dlg.OPEN('#################################1\#################################2');
            IF IngestrelSetup."Update Company Data" THEN BEGIN
                dlg.UPDATE(1, CompanyProcess);
                ProcessCompanyData;
            END;
            IF IngestrelSetup."Update Customer Data" THEN BEGIN
                dlg.UPDATE(1, CustomerProcess);
                ProcessCustomerData;
            END;
            IF IngestrelSetup."Update Employees Data" THEN BEGIN
                dlg.UPDATE(1, EmployedProcess);
                ProcessEmployeeData;
            END;
            IF IngestrelSetup."Update Serv. Item Data" THEN BEGIN
                dlg.UPDATE(1, ManufactureProcess);
                ProcessManufacturerData; //Error de que esta duplicada la clave cambiar datos dentro de la tabla
                dlg.UPDATE(1, ServiceItemProcess);
                ProcessServiceItemModelData;
                dlg.UPDATE(1, ServiceItemModelProcess);
                ProcessVehicleData;
            END;
            CloseConex;
            dlg.CLOSE;
            EXIT;
        END ELSE
            MESSAGE(errorCon);
    end;

    /// <summary>
    /// SendFTP()
    /// </summary>
    local procedure SendFTP()
    begin
        IF OpenConex() THEN BEGIN
            IngestrelSetup.GET;
            dlg.OPEN('#################################1\#################################2');
            IF IngestrelSetup."Update Customer Data" THEN BEGIN
                dlg.UPDATE(1, CustomerSincro);
                ProcessCustomerFile;
            END;
            IF IngestrelSetup."Update Employees Data" THEN BEGIN
                dlg.UPDATE(1, EmployedSincro);
                ProcessEmployeeFile;
            END;
            IF IngestrelSetup."Update Serv. Item Data" THEN BEGIN
                dlg.UPDATE(1, ServiceItemSincro);
                ProcessServiceItemFile;
            END;
            CloseConex;
            dlg.CLOSE;
        END ELSE
            MESSAGE(errorCon);
    end;

    /// <summary>
    /// ProcessCompanyData()
    /// </summary>
    local procedure ProcessCompanyData()
    var
        CompanyInformation: Record "Company Information";
        CompanyInformation2: Record "Company Information";
    begin
        CLEAR(Company);
        IF Company.FINDSET THEN BEGIN
            REPEAT
                CLEAR(CompanyInformation);
                CompanyInformation.CHANGECOMPANY(Company.Name);
                CompanyInformation.SETRANGE("Export Date", 0D, CALCDATE('-1D', WORKDATE)); //Comparar que la fecha sea vacia // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE
                CompanyInformation.SETRANGE("Export Ingestrel", TRUE); //Comprobar que exportar este en true para realizar el paso de datos
                IF CompanyInformation.FINDFIRST THEN BEGIN
                    dlg.UPDATE(2, Company.Name);
                    // Pasan cosas
                    //Ejecutar lectura para comprobar si existe el registro
                    QueryIns := 'SELECT * FROM empresas WHERE id_empresa="' + Fillblank(CompanyInformation."Company ID") + '";';
                    IF (ReadQuery(QueryIns)) THEN BEGIN
                        //Ejecutar UPDATE
                        QueryIns := 'UPDATE empresas SET id_empresa="' + Fillblank(CompanyInformation."Company ID") + '",cif="' + Fillblank(CompanyInformation."VAT Registration No.")
                        + '",nombre_fiscal="' + Fillblank(CompanyInformation.Name) + '",direccion_fiscal="' + Fillblank(CompanyInformation.Address) + Fillblank(CompanyInformation."Address 2")
                        + '",localidad_fiscal="' + Fillblank(CompanyInformation.City) + '",provincia_fiscal="' + Fillblank(CompanyInformation.County)
                        + '",pais_fiscal="' + Fillblank(CompanyInformation."Country/Region Code") + '",telefono_fiscal="' + Fillblank(CompanyInformation."Phone No.") + '",email_fiscal="' + Fillblank(CompanyInformation."E-Mail")
                        + '",url_fiscal="' + Fillblank(CompanyInformation."Home Page") + '",nombre_comercial="' + Fillblank(CompanyInformation.Name)
                        + '",direccion_comercial="' + Fillblank(CompanyInformation.Address) + Fillblank(CompanyInformation."Address 2")
                        + '",localidad_comercial="' + Fillblank(CompanyInformation.City) + '",provincia_comercial="' + Fillblank(CompanyInformation.County)
                        + '",pais_comercial="' + Fillblank(CompanyInformation."Country/Region Code") + '",telefono_comercial="' + Fillblank(CompanyInformation."Phone No.") + '",email_comercial="' + Fillblank(CompanyInformation."E-Mail")
                        + '",url_comercial="' + Fillblank(CompanyInformation."Home Page") + '",cp_fiscal="' + Fillblank(CompanyInformation."Post Code") + '",cp_comercial="' + Fillblank(CompanyInformation."Post Code")
                        + '",gerente_nombre="' + Fillblank(CompanyInformation."Manager Name") + '",gerente_nif=" ",riesgos_nombre="' + Fillblank(CompanyInformation."Risks Name")
                        + '",riesgos_nif="' + Fillblank(CompanyInformation."Risks CIF") + '",riesgos_titulacion=" ",comite_nombre="' + Fillblank(CompanyInformation."Committee Name")
                        + '",comite_nif="' + Fillblank(CompanyInformation."Committee CIF") + '",logo="' + Fillblank(CompanyInformation.Logo)
                        + '",gerente_firma="' + Fillblank(CompanyInformation."Signature Manager") + '",riesgos_firma="' + Fillblank(CompanyInformation."Signature Risks") + '",comite_firma="' + Fillblank(CompanyInformation."Signature Risks")
                        + '",color="' + Fillblank(CompanyInformation.Colour) + '",zonaprivada=true WHERE id_empresa="' + Fillblank(CompanyInformation."Company ID") + '";';
                    END ELSE BEGIN
                        //Ejecutar INSERT
                        QueryIns := 'INSERT INTO empresas (id_empresa,cif,nombre_fiscal,direccion_fiscal,localidad_fiscal,provincia_fiscal,pais_fiscal,' +
                        'telefono_fiscal,email_fiscal,url_fiscal,nombre_comercial,direccion_comercial,localidad_comercial,provincia_comercial,pais_comercial,telefono_comercial,' +
                        'email_comercial,url_comercial,cp_fiscal,cp_comercial,gerente_nombre,gerente_nif,riesgos_nombre,riesgos_nif,riesgos_titulacion,comite_nombre,comite_nif,logo,gerente_firma,riesgos_firma,' +
                        'comite_firma,color,zonaprivada) VALUES ("' + Fillblank(CompanyInformation."Company ID") + '","' + Fillblank(CompanyInformation."VAT Registration No.") + '","' + Fillblank(CompanyInformation.Name) +
                        '","' + Fillblank(CompanyInformation.Address) + Fillblank(CompanyInformation."Address 2") + '","' + Fillblank(CompanyInformation.City) + '","' + Fillblank(CompanyInformation.County) +
                        '","' + Fillblank(CompanyInformation."Country/Region Code") + '","' + Fillblank(CompanyInformation."Phone No.") + '","' + Fillblank(CompanyInformation."E-Mail") + '","' + Fillblank(CompanyInformation."Home Page") +
                        '","' + Fillblank(CompanyInformation.Name) + '","' + Fillblank(CompanyInformation.Address) + Fillblank(CompanyInformation."Address 2") + '","' + Fillblank(CompanyInformation.City) + '","' + Fillblank(CompanyInformation.County) +
                        '","' + Fillblank(CompanyInformation."Country/Region Code") + '","' + Fillblank(CompanyInformation."Phone No.") + '","' + Fillblank(CompanyInformation."E-Mail") +
                        '","' + Fillblank(CompanyInformation."Home Page") + '","' + Fillblank(CompanyInformation."Post Code") + '","' + Fillblank(CompanyInformation."Post Code") +
                        '","' + Fillblank(CompanyInformation."Manager Name") + '","' + Fillblank(CompanyInformation."Manager CIF") + '","' + Fillblank(CompanyInformation."Risks Name") + '","' + Fillblank(CompanyInformation."Risks CIF") +
                        '"," ","' + Fillblank(CompanyInformation."Committee Name") + '","' + Fillblank(CompanyInformation."Committee CIF") + '","' + Fillblank(CompanyInformation.Logo) +
                        '","' + Fillblank(CompanyInformation."Signature Manager") + '","' + Fillblank(CompanyInformation."Signature Risks") + '","' + Fillblank(CompanyInformation."Signature Risks") +
                        '","' + Fillblank(CompanyInformation.Colour) + '",true)';
                    END;
                    exportQuery(QueryIns, 'Empresa_' + Company.Name);
                    ExecuteQuery(QueryIns);
                    CompanyInformation."Export Date" := WORKDATE;
                    CompanyInformation.MODIFY;
                    CLEAR(QueryIns);
                END;
            UNTIL Company.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessCustomerData()
    /// </summary>
    local procedure ProcessCustomerData()
    begin
        CLEAR(Customer);
        Customer.SETRANGE("Ingestrel Export Date", 0D, CALCDATE('-1D', WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE
        Customer.SETRANGE("Ingestrel Export", TRUE);
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                dlg.UPDATE(2, Customer.Name);
                //Si toca borrar, paso por otro lado
                IF Customer."Extranet Deletion" THEN BEGIN
                    QueryDel := 'DELETE FROM clientes WHERE id_cliente="' + Fillblank(Customer."No.") + '";';
                    exportQuery(QueryDel, 'Cliente_' + Customer."No.");
                    ExecuteQuery(QueryDel);
                    Customer."Last Export Date" := 0D;
                    Customer."Ingestrel Export" := FALSE;
                    Customer."Extranet Deletion" := FALSE;
                END ELSE BEGIN
                    QueryIns := 'SELECT * FROM clientes WHERE id_cliente="' + Fillblank(Customer."No.") + '";';
                    IF (ReadQuery(QueryIns)) THEN
                        //Ejecutar UPDATE
                        QueryIns := 'UPDATE clientes SET id_cliente="' + Fillblank(Customer."No.") + '",id_empresa="' + '1' + '",fecha_alta="01/01/0001",situacion_alta="En Proceso",nif_cif="' + Fillblank(Customer."VAT Registration No.")
                  + '",nombre_fiscal="' + Fillblank(Customer.Name) + '",direccion_fiscal="' + Fillblank(Customer.Address + Customer."Address 2")
                  + '",localidad_fiscal="' + Fillblank(Customer.City) + '",provincia_fiscal="' + Fillblank(Customer.County) + '",comunidad_fiscal="" "",pais_fiscal="' + Fillblank(Customer."Country/Region Code")
                  + '",nombre_comercial="' + Fillblank(Customer.Name)
                  + '",direccion_comercial="' + Fillblank(Customer.Address + Customer."Address 2") + '",localidad_comercial="' + Fillblank(Customer.City)
                  + '",provincia_comercial="' + Fillblank(Customer.County) + '",comunidad_comercial="" "",pais_comercial="' + Fillblank(Customer."Country/Region Code") + '",cod_postal_fiscal=" ",cod_postal_comercial="' + Fillblank(Customer."Post Code")
                  + '",telefono="' + Fillblank(Customer."Phone No.") + '",telefono_2=" ",fax="' + Fillblank(Customer."Fax No.") + '",email="' + Fillblank(Customer."E-Mail")
                  + '",web="' + Fillblank(Customer."Home Page") + '",zonaprivada=true WHERE id_cliente="' + Fillblank(Customer."No.") + '";'
                    ELSE
                        //Ejecutar INSERT
                        QueryIns := 'INSERT INTO clientes (id_cliente,id_empresa,fecha_alta,situacion_alta,nif_cif,nombre_fiscal,direccion_fiscal,localidad_fiscal,provincia_fiscal,comunidad_fiscal,' +
                  'pais_fiscal,nombre_comercial,direccion_comercial,localidad_comercial,provincia_comercial,comunidad_comercial,pais_comercial,cod_postal_fiscal,cod_postal_comercial,telefono,telefono_2,fax,email,web,zonaprivada)' +
                  'VALUES ("' + Fillblank(Customer."No.") +
                  '","' + '1' + '","' + Fillblank(FormatDate(Customer."Creation Date")) + '","En proceso","' + Fillblank(Customer."VAT Registration No.") + '","' + Fillblank(Customer.Name) +
                  '","' + Fillblank(Customer.Address + Customer."Address 2") + '","' + Fillblank(Customer.City) +
                  '","' + Fillblank(Customer.County) + '"," ","' + Fillblank(Customer."Country/Region Code") + '","' + Fillblank(Customer.Name) +
                  '","' + Fillblank(Customer.Address + Customer."Address 2") + '","' + Fillblank(Customer.City) + '","' + Fillblank(Customer.County) +
                  '"," ","' + Fillblank(Customer."Country/Region Code") + '"," ","' + Fillblank(Customer."Post Code") + '","' + Fillblank(Customer."Phone No.") +
                  '"," ","' + Fillblank(Customer."Fax No.") + '","' + Fillblank(Customer."E-Mail") + '","' + Fillblank(Customer."Home Page") + '",true);';
                    exportQuery(QueryIns, 'Cliente_' + Customer."No.");
                    ExecuteQuery(QueryIns);
                    Customer."Ingestrel Export Date" := WORKDATE;
                END;
                Customer.MODIFY;
                COMMIT;
            UNTIL Customer.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessEmployeeData()
    /// </summary>
    local procedure ProcessEmployeeData()
    begin
        CLEAR(Employee);
        // Employee.SETRANGE("Last Export Date",0D,CALCDATE('-1D',WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE
        Employee.SETRANGE("Ingestrel Export", TRUE);
        IF Employee.FINDSET THEN BEGIN
            REPEAT
                dlg.UPDATE(2, Employee.Name);
                //Si toca borrar, paso por otro lado
                IF Employee."Extranet Deletion" THEN BEGIN
                    QueryDel := 'DELETE FROM empleados WHERE id_empleado="' + Fillblank(Employee."No.") + '";';
                    exportQuery(QueryDel, 'Empleado_' + Employee."No.");
                    ExecuteQuery(QueryDel);
                    Employee."Last Export Date" := 0D;
                    Employee."Ingestrel Export" := FALSE;
                    Employee."Extranet Deletion" := FALSE;
                END ELSE BEGIN
                    QueryIns := 'SELECT * FROM empleados WHERE id_empleado="' + Fillblank(Employee."No.") + '";';
                    IF (ReadQuery(QueryIns)) THEN
                        //Ejecutar UPDATE
                        QueryIns := 'UPDATE empleados SET id_empleado="' + Fillblank(Employee."No.") + '",id_empresa="' + '1' + '",fecha_alta="' + Fillblank(FormatDate(Employee."Employment Date"))
              + '",nif="' + Fillblank(Employee."VAT Registration No.") + '",nombre="' + Fillblank(Employee.Name)
              + '",apellidos="' + Fillblank(Employee."First Family Name" + ' ' + Employee."Second Family Name") + '",telefono="' + Fillblank(Employee."Phone No.")
              + '",telefono_2="' + Fillblank(Employee."Mobile Phone No.") + '",fax="' + Fillblank(Employee."Fax No.")
              + '",email="' + Fillblank(Employee."E-Mail") + '",cargo="' + Fillblank(Employee."Job Title") + '",zonaprivada=true WHERE id_empleado="' + Fillblank(Employee."No.") + '";'
                    ELSE
                        //Ejecutar INSERT
                        QueryIns := 'INSERT INTO empleados (id_empleado,id_empresa,fecha_alta,nif,nombre,apellidos,telefono,telefono_2,fax,email,cargo,zonaprivada) VALUES ("' + Fillblank(Employee."No.")
              + '","' + '1' + '","' + Fillblank(FormatDate(Employee."Employment Date")) + '","' + Fillblank(Employee."VAT Registration No.") + '","' + Fillblank(Employee.Name) + '","' +
              Fillblank(Employee."First Family Name" + ' ' + Employee."Second Family Name") + '","","","' +
              Fillblank(Employee."Fax No.") + '","' + Fillblank(Employee."E-Mail") + '","' + Fillblank(Employee."Job Title") + '",true);';
                    exportQuery(QueryIns, 'Empleado_' + Employee."No.");
                    ExecuteQuery(QueryIns);
                    Employee."Last Export Date" := WORKDATE;
                END;
                Employee.MODIFY;
                COMMIT;
            UNTIL Employee.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessManufacturerData()
    /// </summary>
    local procedure ProcessManufacturerData()
    begin
        CLEAR(Manufacturer);
        IF Manufacturer.FINDSET THEN BEGIN
            REPEAT
                dlg.UPDATE(2, Manufacturer.Name);
                QueryIns := 'SELECT * FROM vehiculos_marcas WHERE id_marca="' + Fillblank(Manufacturer.Code) + '";';
                IF (ReadQuery(QueryIns)) THEN
                    //Ejecutar UPDATE
                    QueryIns := 'UPDATE vehiculos_marcas SET id_marca="' + Fillblank(Manufacturer.Code) + '",nombre="' + Fillblank(Manufacturer.Name)
                + '",zonaprivada=true WHERE id_marca="' + Fillblank(Manufacturer.Code) + '";'
                ELSE
                    //Ejecutar INSERT
                    QueryIns := 'INSERT INTO vehiculos_marcas (id_marca,nombre,zonaprivada) VALUES ("' + Fillblank(Manufacturer.Code)
                + '","' + Fillblank(Manufacturer.Name) + '",true);';
                ExecuteQuery(QueryIns);
            UNTIL Manufacturer.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessVehicleData()
    /// </summary>
    local procedure ProcessVehicleData()
    begin
        CLEAR(ServiceItem);
        // ServiceItem.SETRANGE("Last Export Date",0D,CALCDATE('-1D',WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE
        ServiceItem.SETRANGE("Ingestrel Export", TRUE);
        IF ServiceItem.FINDSET THEN BEGIN
            REPEAT
                dlg.UPDATE(2, ServiceItem.Name);
                //Si toca borrar, paso por otro lado
                IF ServiceItem."Extranet Deletion" THEN BEGIN
                    QueryDel := 'DELETE FROM vehiculos WHERE id_vehiculo="' + Fillblank(ServiceItem."No.") + '";';
                    exportQuery(QueryDel, 'Vehiculo_' + ServiceItem."No.");
                    ExecuteQuery(QueryDel);
                    ServiceItem."Last Export Date" := 0D;
                    ServiceItem."Ingestrel Export" := FALSE;
                    ServiceItem."Extranet Deletion" := FALSE;
                END ELSE BEGIN
                    QueryIns := 'SELECT * FROM vehiculos WHERE id_vehiculo="' + Fillblank(ServiceItem."No.") + '";';
                    IF (ReadQuery(QueryIns)) THEN
                        //Ejecutar UPDATE
                        QueryIns := 'UPDATE vehiculos SET id_vehiculo="' + Fillblank(ServiceItem."No.") + '",id_empresa="' + '1' + '",id_grupo="' + Fillblank(ServiceItem."Model Code")
                  + '",id_marca="' + Fillblank(ServiceItem."Manufacturer Code") + '",fecha_alta="' + Fillblank(FORMAT(ServiceItem."Installation Date")) + '",numero="' + Fillblank(ServiceItem."Planner No")
                  + '",matricula="' + Fillblank(ServiceItem."Plate No.")
                  + '",modelo="' + Fillblank(ServiceItem.Description) + '",zonaprivada=true WHERE id_vehiculo="' + Fillblank(ServiceItem."No.") + '";'
                    ELSE
                        //Ejecutar INSERT
                        QueryIns := 'INSERT INTO vehiculos (id_vehiculo,id_empresa,id_grupo,id_marca,fecha_alta,numero,matricula,modelo,zonaprivada) VALUES ("' + Fillblank(ServiceItem."No.")
                  + '","' + '1' + '","' + Fillblank(ServiceItem."Model Code") + '","' + Fillblank(ServiceItem."Manufacturer Code") + '","' + Fillblank(FormatDate(ServiceItem."Installation Date"))
                  + '","' + Fillblank(ServiceItem."Planner No") + '","' + Fillblank(ServiceItem."Plate No.") + '","' + Fillblank(ServiceItem.Description) + '",true);';
                    exportQuery(QueryIns, 'Vehiculo_' + ServiceItem."No.");
                    ExecuteQuery(QueryIns);
                    ServiceItem."Last Export Date" := WORKDATE;
                END;
                ServiceItem.MODIFY;
                COMMIT;
            UNTIL ServiceItem.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessServiceItemModelData()
    /// </summary>
    local procedure ProcessServiceItemModelData()
    var
        ServiceItemModel2: Record "Service Item Model_LDR";
    begin
        CLEAR(ServiceItemModel);
        IF ServiceItemModel.FINDSET THEN BEGIN
            REPEAT
                dlg.UPDATE(2, ServiceItemModel.Code);
                QueryIns := 'SELECT * FROM vehiculos_grupos WHERE id_grupo="' + Fillblank(ServiceItemModel.Code) + '";';
                IF (ReadQuery(QueryIns)) THEN
                    //Ejecutar UPDATE
                    QueryIns := 'UPDATE vehiculos_grupos SET id_grupo="' + Fillblank(ServiceItemModel.Code) + '",tonelaje="' + Fillblank(FORMAT(ServiceItemModel.Tonnage))
                + '",modelo="' + Fillblank(ServiceItemModel.Description) + '",modelo="true" WHERE id_grupo="' + Fillblank(ServiceItemModel.Code) + '";'
                ELSE
                    //Ejecutar INSERT
                    QueryIns := 'INSERT INTO vehiculos_grupos (id_grupo,tonelaje,modelo,zonaprivada) VALUES ("' + Fillblank(ServiceItemModel.Code)
                + '","' + Fillblank(FORMAT(ServiceItemModel.Tonnage)) + '","' + Fillblank(ServiceItemModel.Description) + '",true);';
                ExecuteQuery(QueryIns);
            UNTIL Manufacturer.NEXT = 0;
        END;
    end;

    /// <summary>
    /// ProcessCustomerFile()
    /// </summary>
    local procedure ProcessCustomerFile()
    var
        MyFile: File;
        RecordLink2: Record "Record Link";
    begin
        CLEAR(Customer);
        Customer.SETRANGE("Ingestrel Export", TRUE);
        IF Customer.FINDSET THEN BEGIN
            //Si existe el fichero lo borro y lo vuelvo a crear
            IF EXISTS('C:\Temp\CustomerProcessData.bat') THEN
                ERASE('C:\Temp\CustomerProcessData.bat');
            //Crear fichero script llamando a la funcion especifica para ello.
            ServerFileName := FileManagement.ServerTempFileName('tmp');
            MyFile.CREATE(ServerFileName);
            MyFile.TEXTMODE(TRUE);
            MyFile.WRITE('@echo off');
            REPEAT
                dlg.UPDATE(2, Customer.Name);
                CLEAR(RecordLink);
                RecordLink.SETRANGE("Record ID", Customer.RECORDID);
                RecordLink.SETRANGE(Type, RecordLink.Type::Link);
                RecordLink.SETRANGE("Export to Ingestrel", TRUE); //TODO: Error: Export to Ingestrel no existe en este SetRange
                RecordLink.SETRANGE("Ingestrel Export Date", 0D, CALCDATE('-1D', WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE //TODO: Error: Ingestrel Export Date no existe en este SetRange
                IF RecordLink.FINDSET THEN BEGIN
                    REPEAT
                        //Comprobar si se encuentra fichero para evitar error.
                        IF EXISTS(RecordLink.URL1) THEN BEGIN
                            //Añadir al fichero(rutafichero)
                            MyFile.WRITE('NcFTPput' +
                                         ' -u ' + IngestrelSetup."FTP User" +
                                         ' -p ' + IngestrelSetup."FTP Password" +
                                         ' -P ' + FORMAT(IngestrelSetup."FTP Port") +
                                         ' -C ' + IngestrelSetup."FTP Address" +
                                         ' "' + RecordLink.URL1 +
                                         //'" ' + '"' + IngestrelSetup."FTP Directory"+ RecordLink."Ingestrel File Name" + '"');
                                         '" ' + '"\clientes_documentos\' + FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name" + '"'); //TODO: Error: Ingestrel File Date no existe en este RecordLink


                            QueryIns := 'SELECT * FROM clientes_documentos WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";';
                            IF (ReadQuery(QueryIns)) THEN
                                //Ejecutar UPDATE
                                QueryIns := 'UPDATE clientes_documentos SET id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '",id_empleado="' + Fillblank(Customer."No.") + '",fecha_alta="' + Fillblank(FormatDate(WORKDATE))
                     + '",nombre="' + Fillblank(RecordLink."Ingestrel Name") + '",descripcion="' + Fillblank(RecordLink.Description) + '",documento="' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") //TODO: Error: Ingestrel File Name y Ingestrel Name no existe en este RecordLink
                     + '",zonaprivada=true WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";'
                            ELSE
                                //Ejecutar INSERT
                                QueryIns := 'INSERT INTO clientes_documentos (id_documento, id_cliente, fecha_alta, nombre, descripcion, documento, zonaprivada) VALUES ("NAV_' + FORMAT(RecordLink."Link ID") +
                                 '","' + Fillblank(Customer."No.") + '","' + Fillblank(FormatDate(WORKDATE)) + '","' + Fillblank(RecordLink."Ingestrel Name") + '","' +  //TODO: Error: Ingestrel Name no existe en este RecordLink
                                 Fillblank(RecordLink.Description) + '","' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") + '",true)'; //TODO: Error: Ingestrel File Name no existe en este RecordLink
                            exportQuery(QueryIns, 'Cliente_Documentos_' + FORMAT(RecordLink."Link ID"));
                            ExecuteQuery(QueryIns);

                            RecordLink."Ingestrel Export Date" := WORKDATE; //TODO: Error: Ingestrel Export Date no existe en este RecordLink
                            RecordLink.MODIFY;
                        END
                    UNTIL RecordLink.NEXT = 0;
                END;
            UNTIL Customer.NEXT = 0;
            //Cerrar fichero
            MyFile.WRITE('echo %errorlevel%');
            MyFile.WRITE('IF %errorlevel%==0 (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo TRANSFERENCIA REALIZADA CORRECTAMENTE');
            MyFile.WRITE('echo.');
            MyFile.WRITE(') ELSE (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo ERROR EN LA TRANSFERENCIA');
            MyFile.WRITE('echo.');
            MyFile.WRITE(')');
            MyFile.WRITE('Pause');
            MyFile.CLOSE;
            FileManagement.CopyServerFile(ServerFileName, 'C:\Temp\CustomerProcessData.bat', TRUE);
            executeshell('C:\Temp\CustomerProcessData.bat');
        END;
    end;

    /// <summary>
    /// ProcessEmployeeFile()
    /// </summary>
    local procedure ProcessEmployeeFile()
    var
        MyFile: File;
        RecordLink2: Record "Record Link";
    begin
        CLEAR(Employee);
        Employee.SETRANGE("Ingestrel Export", TRUE);
        IF Employee.FINDSET THEN BEGIN
            //Si existe el fichero lo borro y lo vuelvo a crear
            IF EXISTS('C:\Temp\EmployeeProcessData.bat') THEN
                ERASE('C:\Temp\EmployeeProcessData.bat');
            //Crear fichero script llamando a la funcion especifica para ello.
            ServerFileName := FileManagement.ServerTempFileName('tmp');
            MyFile.CREATE(ServerFileName);
            MyFile.TEXTMODE(TRUE);
            MyFile.WRITE('@echo off');
            REPEAT
                dlg.UPDATE(2, Employee.Name);
                CLEAR(RecordLink);
                RecordLink.SETRANGE("Record ID", Employee.RECORDID);
                RecordLink.SETRANGE(Type, RecordLink.Type::Link);
                RecordLink.SETRANGE("Export to Ingestrel", TRUE); //TODO: Error: Export to Ingestrel no existe en este SetRange
                RecordLink.SETRANGE("Ingestrel Export Date", 0D, CALCDATE('-1D', WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE //TODO: Error: Ingestrel Export Date no existe en este SetRange
                IF RecordLink.FINDSET THEN BEGIN
                    REPEAT
                        //Comprobar si se encuentra fichero para evitar error.
                        IF EXISTS(RecordLink.URL1) THEN BEGIN
                            //Añadir al fichero(rutafichero)
                            MyFile.WRITE('NcFTPput' +
                                         ' -u ' + IngestrelSetup."FTP User" +
                                         ' -p ' + IngestrelSetup."FTP Password" +
                                         ' -P ' + FORMAT(IngestrelSetup."FTP Port") +
                                         ' -C ' + IngestrelSetup."FTP Address" +
                                         ' "' + RecordLink.URL1 +
                                         //'" ' + '"' + IngestrelSetup."FTP Directory"+ RecordLink."Ingestrel File Name" + '"');
                                         '" ' + '"/empleados_documentos/' + FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name" + '"'); //TODO: Error: Ingestrel File Date no existe en este RecordLink



                            QueryIns := 'SELECT * FROM empleados_documentos WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";';
                            IF (ReadQuery(QueryIns)) THEN
                                //Ejecutar UPDATE
                                QueryIns := 'UPDATE empleados_documentos SET id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '",id_empleado="' + Fillblank(Employee."No.") + '",fecha_alta="' + Fillblank(FormatDate(WORKDATE))
                      + '",nombre="' + Fillblank(RecordLink."Ingestrel Name") + '",descripcion="' + Fillblank(RecordLink.Description) + '",documento="' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") //TODO: Error: Ingestrel File Name y Ingestrel Name no existe en este RecordLink
                      + '",zonaprivada=true WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";'
                            ELSE
                                //Ejecutar INSERT
                                QueryIns := 'INSERT INTO empleados_documentos (id_documento, id_empleado, fecha_alta, nombre, descripcion, documento, zonaprivada) VALUES ("NAV_' + FORMAT(RecordLink."Link ID") +
                                  '","' + Fillblank(Employee."No.") + '","' + Fillblank(FormatDate(WORKDATE)) + '","' + Fillblank(RecordLink."Ingestrel Name") + '","' + //TODO: Error: Ingestrel Name no existe en este RecordLink
                                  Fillblank(RecordLink.Description) + '","' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") + '",true)'; //TODO: Error: Ingestrel File Name no existe en este RecordLink
                            exportQuery(QueryIns, 'Empleado_Documentos_' + FORMAT(RecordLink."Link ID"));
                            ExecuteQuery(QueryIns);

                            RecordLink."Ingestrel Export Date" := WORKDATE; //TODO: Error: Ingestrel Export Date no existe en este RecordLink
                            RecordLink.MODIFY;
                            COMMIT;
                        END
                    UNTIL RecordLink.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
            //Cerrar fichero
            MyFile.WRITE('echo %errorlevel%');
            MyFile.WRITE('IF %errorlevel%==0 (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo TRANSFERENCIA REALIZADA CORRECTAMENTE');
            MyFile.WRITE('echo.');
            MyFile.WRITE(') ELSE (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo ERROR EN LA TRANSFERENCIA');
            MyFile.WRITE('echo.');
            MyFile.WRITE(')');
            MyFile.WRITE('Pause');
            MyFile.CLOSE;
            FileManagement.CopyServerFile(ServerFileName, 'C:\Temp\EmployeeProcessData.bat', TRUE);
            executeshell('C:\Temp\EmployeeProcessData.bat');
        END;
    end;

    /// <summary>
    /// ProcessServiceItemFile()
    /// </summary>
    local procedure ProcessServiceItemFile()
    var
        MyFile: File;
        RecordLink2: Record "Record Link";
    begin
        CLEAR(ServiceItem);
        ServiceItem.SETRANGE("Ingestrel Export", TRUE);
        IF ServiceItem.FINDSET THEN BEGIN
            //Si existe el fichero lo borro y lo vuelvo a crear
            IF EXISTS('C:\Temp\ServiceItemProcessData.bat') THEN
                ERASE('C:\Temp\ServiceItemProcessData.bat');
            //Crear fichero script llamando a la funcion especifica para ello.
            ServerFileName := FileManagement.ServerTempFileName('tmp');
            MyFile.CREATE(ServerFileName);
            MyFile.TEXTMODE(TRUE);
            MyFile.WRITE('@echo off');
            REPEAT
                dlg.UPDATE(2, ServiceItem.Name);
                CLEAR(RecordLink);
                RecordLink.SETRANGE("Record ID", ServiceItem.RECORDID);
                RecordLink.SETRANGE(Type, RecordLink.Type::Link);
                RecordLink.SETRANGE("Export to Ingestrel", TRUE); //TODO: Error: Export to Ingestrel no existe en este SetRange
                RecordLink.SETRANGE("Ingestrel Export Date", 0D, CALCDATE('-1D', WORKDATE)); // RQ19.24.422 - DPGARCIA - Filtrar por fecha vacía o menor a WORKDATE //TODO: Error: Ingestrel Export Date no existe en este SetRange
                IF RecordLink.FINDSET THEN BEGIN
                    REPEAT
                        //Comprobar si se encuentra fichero para evitar error.
                        IF EXISTS(RecordLink.URL1) THEN BEGIN
                            //Añadir al fichero(rutafichero)
                            MyFile.WRITE('NcFTPput' +
                                         ' -u ' + IngestrelSetup."FTP User" +
                                         ' -p ' + IngestrelSetup."FTP Password" +
                                         ' -P ' + FORMAT(IngestrelSetup."FTP Port") +
                                         ' -C ' + IngestrelSetup."FTP Address" +
                                         ' "' + RecordLink.URL1 +
                                         //'" ' + '"' + IngestrelSetup."FTP Directory"+ RecordLink."Ingestrel File Name" + '"');
                                         '" ' + '"/vehiculos_documentos/' + FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name" + '"'); //TODO: Error: Ingestrel File Date no existe en este RecordLink


                            QueryIns := 'SELECT * FROM vehiculos_documentos WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";';
                            IF (ReadQuery(QueryIns)) THEN
                                //Ejecutar UPDATE
                                QueryIns := 'UPDATE vehiculos_documentos SET id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '",id_vehiculo="' + Fillblank(ServiceItem."No.") + '",fecha_alta="' + Fillblank(FormatDate(WORKDATE))
                      + '",nombre="' + Fillblank(RecordLink."Ingestrel Name") + '",descripcion="' + Fillblank(RecordLink.Description) + '",documento="' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") //TODO: Error: Ingestrel File Name y Ingestrel Name no existe en este RecordLink
                      + '",zonaprivada=true WHERE id_documento="NAV_' + FORMAT(RecordLink."Link ID") + '";'
                            ELSE
                                //Ejecutar INSERT
                                QueryIns := 'INSERT INTO vehiculos_documentos (id_documento, id_vehiculo, fecha_alta, nombre, descripcion, documento, zonaprivada) VALUES ("NAV_' + FORMAT(RecordLink."Link ID") +
                                  '","' + Fillblank(ServiceItem."No.") + '","' + Fillblank(FormatDate(WORKDATE)) + '","' + Fillblank(RecordLink."Ingestrel Name") + '","' + //TODO: Error: Ingestrel Name no existe en este RecordLink
                                  Fillblank(RecordLink.Description) + '","' + Fillblank(FORMAT(RecordLink."Link ID") + '-' + RecordLink."Ingestrel File Name") + '",true)'; //TODO: Error: Ingestrel File Name no existe en este RecordLink
                            exportQuery(QueryIns, 'Vehiculos_Documentos_' + FORMAT(RecordLink."Link ID"));
                            ExecuteQuery(QueryIns);

                            RecordLink."Ingestrel Export Date" := WORKDATE; //TODO: Error: Ingestrel Export Date no existe en este RecordLink
                            RecordLink.MODIFY;
                        END
                    UNTIL RecordLink.NEXT = 0;
                END;
            UNTIL ServiceItem.NEXT = 0;
            //Cerrar fichero
            MyFile.WRITE('echo %errorlevel%');
            MyFile.WRITE('IF %errorlevel%==0 (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo TRANSFERENCIA REALIZADA CORRECTAMENTE');
            MyFile.WRITE('echo.');
            MyFile.WRITE(') ELSE (');
            MyFile.WRITE('echo.');
            MyFile.WRITE('echo ERROR EN LA TRANSFERENCIA');
            MyFile.WRITE('echo.');
            MyFile.WRITE(')');
            MyFile.WRITE('Pause');
            MyFile.CLOSE;
            FileManagement.CopyServerFile(ServerFileName, 'C:\Temp\ServiceItemProcessData.bat', TRUE);
            executeshell('C:\Temp\ServiceItemProcessData.bat');
        END;
    end;

    /// <summary>
    /// OpenConex()
    /// </summary>
    procedure OpenConex() Suceed: BoolEAN
    begin
        //Abrir la conexion con el servidor
        Conexion2MySql := Conexion2MySql.MySqlConnection;
        IngestrelSetup.GET;
        Conexion2MySql.ConnectionString('Server=' + IngestrelSetup."Server IP Address" + ';Port=' + FORMAT(IngestrelSetup."Server TCP Port") + ';Database=' + IngestrelSetup.BBDD
        + ';Uid=' + IngestrelSetup.User + ';Pwd=' + IngestrelSetup.Password + ';');
        Conexion2MySql.Open;
        EXIT(TRUE);
    end;

    /// <summary>
    /// ReadQuery()
    /// </summary>
    procedure ReadQuery(Command: Text) Exists: BoolEAN
    begin
        //Ejecutar lectura
        Command2MySql := Command2MySql.MySqlCommand;
        Command2MySql.Connection := Conexion2MySql;
        Command2MySql.CommandText := Command;
        Reader := Command2MySql.ExecuteReader;
        //Comprobar si existe
        IF Reader.Read() THEN BEGIN
            Reader.Close; //Se tiene que cerrar la variable de lectura
            EXIT(TRUE);
        END ELSE
            Reader.Close; //Se tiene que cerrar la variable de lectura
        EXIT(FALSE);
    end;

    /// <summary>
    /// ExecuteQuery()
    /// </summary>
    procedure ExecuteQuery(Command: Text) Sucess: BoolEAN
    var
        contador: Integer;
        tempInp: Integer;
    begin
        //ejecutar llamada no consulta
        Command2MySql := Command2MySql.MySqlCommand;
        Command2MySql.Connection := Conexion2MySql;
        Command2MySql.CommandText := Command;
        tempInp := Command2MySql.ExecuteNonQuery();
    end;

    /// <summary>
    /// CloseConex()
    /// </summary>
    procedure CloseConex() Suceed: BoolEAN
    begin
        //Cerrar conexion
        Conexion2MySql.Close;
    end;

    /// <summary>
    /// Fillblank()
    /// </summary>
    local procedure Fillblank(InVar: Text) ReVar: Text
    begin
        //Funcion para que en caso de que un campo sea blanco se rellene con un espacio ya que todos los campos de la BBDD son Not_Null
        IF STRLEN(InVar) = 0 THEN
            InVar := ' ';
        ReVar := ClEANText(InVar);
        EXIT(ReVar);
    end;

    /// <summary>
    /// executeshell()
    /// </summary>
    local procedure executeshell(FilePath: Text)
    var
        Process: DotNet Process; //TODO: Error: No existe el Dotnet Process
        IngestrelSetup: Record "Ingestrel Setup_LDR";
        Params: Text;
    begin
        Process := Process.Process();
        Process.StartInfo.FileName := FilePath;
        Process.StartInfo.Arguments := '';
        Process.StartInfo.UseShellExecute := FALSE;
        Process.StartInfo.RedirectStandardOutput := TRUE;
        Process.Start(FilePath);
    end;

    /// <summary>
    /// CreateVehicleBook()
    /// </summary>
    procedure CreateVehicleBook(pRecRef: RecordRef)
    var
        RecordLink: Record "Record Link";
        FileName: Text;
    begin
        IngestrelSetup.GET;
        IngestrelSetup.TESTFIELD("Vehicle Book Directory");
        //con el Record ID pasado por parametros,

        ServiceItem.SETPOSITION(pRecRef.GETPOSITION);
        ServiceItem.GET(ServiceItem."No.");
        ServiceItem.SETRECFILTER;

        dlg.OPEN('Procesando Prod. Servicio ########1 ########################################2');
        dlg.UPDATE(1, ServiceItem."No.");
        dlg.UPDATE(2, ServiceItem.Description);

        //ejecutamos el report para grabarlo en PDF en la ubicacion configurada.
        FileName := 'Libro_Vehiculo_' + ServiceItem."No." + '_' + ServiceItem."Planner No" + '.pdf';
        REPORT.SAVEASPDF(50010, IngestrelSetup."Vehicle Book Directory" + '\' + FileName, ServiceItem);

        //eliminamos el recordlink de dicho vehiculo que sea "libro de historial"
        CLEAR(RecordLink);
        RecordLink.SETRANGE("Record ID", pRecRef.RECORDID);
        RecordLink.SETRANGE("Vehicle Book Document", TRUE); //TODO: Error: Vehicle Book Document no existe en este SetRange
        IF RecordLink.FINDFIRST THEN BEGIN
            // RQ19.24.246 - DPGARCIA - Cuando ya existe el RecordLink, tiene que limpiar la fecha y marcar el check de Exportar para que se vuelva a exportar de nuevo
            RecordLink."Export to Ingestrel" := TRUE; //TODO: Error: Export to Ingestrel no existe en este RecordLink
            RecordLink."Ingestrel Export Date" := 0D; //TODO: Error: Ingestrel Export Date no existe en este RecordLink
            RecordLink.MODIFY(TRUE);
        END ELSE BEGIN
            //creamos un recordlink nuevo.
            CLEAR(RecordLink);
            RecordLink."Record ID" := pRecRef.RECORDID;
            RecordLink.URL1 := IngestrelSetup."Vehicle Book Directory" + '\' + FileName;
            RecordLink.Description := FileName;
            RecordLink."Vehicle Book Document" := TRUE; //TODO: Error: Vehicle Book Document no existe en este RecordLink
            RecordLink."Export to Ingestrel" := TRUE; //TODO: Error: Export to Ingestrel no existe en este RecordLink
            RecordLink.INSERT(TRUE);
        END;
        dlg.CLOSE;
    end;

    /// <summary>
    /// exportQuery()
    /// </summary>
    local procedure exportQuery(pQuery: Text; pTitle: Text)
    var
        myFile: File;
        myFileName: Text;
    begin
        myFileName := 'C:\Temp\' + pTitle + '.txt';

        IF EXISTS(myFileName) THEN
            ERASE(myFileName);

        CLEAR(myFile);
        myFile.WRITEMODE(TRUE);
        myFile.TEXTMODE(TRUE);
        myFile.CREATE(myFileName);
        myFile.WRITE(pQuery);
        myFile.CLOSE;
        COMMIT;
    end;

    /// <summary>
    /// FormatDate()
    /// </summary>
    local procedure FormatDate(pDate: Date): Text
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        textDate: Text;
    begin
        IF pDate = 0D THEN
            pDate := DMY2DATE(1, 1, 2000);

        lDay := DATE2DMY(pDate, 1);
        lMonth := DATE2DMY(pDate, 2);
        lYear := DATE2DMY(pDate, 3);

        textDate := FORMAT(lYear) + '-' + FORMAT(lMonth) + '-' + FORMAT(lDay);

        EXIT(textDate);
    end;

    /// <summary>
    /// ClEANText()
    /// </summary>
    procedure ClEANText(pText: Text) FIleName: Text[1024]
    begin
        FIleName := CONVERTSTR(pText, '"', ' ');

        EXIT(FIleName);
    end;

    /// <summary>
    /// OnAfterDeleteRecordLink()
    /// </summary>
    [EventSubscriber(ObjectType::Table, 2000000068, 'OnAfterDeleteEvent', '', false, false)]
    procedure OnAfterDeleteRecordLink(var Rec: Record "Record Link"; RunTrigger: BoolEAN)
    var
        RecID: RecordID;
    begin
        IF (RunTrigger) AND (Rec."Export to Ingestrel") AND (Rec."Ingestrel Export Date" <> 0D) THEN BEGIN //TODO: Error: Export to Ingestrel e Ingestrel Export Date no existe en este RecordLink
            IF OpenConex() THEN BEGIN
                RecID := Rec."Record ID";
                CASE RecID.TABLENO OF
                    18:
                        BEGIN
                            QueryIns := 'SELECT * FROM clientes_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                            QueryDel := 'DELETE FROM clientes_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                        END;
                    5200:
                        BEGIN
                            QueryIns := 'SELECT * FROM empleados_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                            QueryDel := 'DELETE FROM empleados_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                        END;
                    5940:
                        BEGIN
                            QueryIns := 'SELECT * FROM vehiculos_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                            QueryDel := 'DELETE FROM vehiculos_documentos WHERE id_documento="NAV_' + FORMAT(Rec."Link ID") + '";';
                        END;
                END;
                IF (ReadQuery(QueryIns)) THEN BEGIN
                    exportQuery(QueryDel, 'Delete_' + FORMAT(RecordLink."Link ID"));
                    ExecuteQuery(QueryDel);
                END;
                CloseConex;
            END;
        END;
    end;

    trigger Conexion2MySql::InfoMessage(sender: Variant; args: DotNet MySqlInfoMessageEventArgs) //TODO: Error: No existe el Dotnet MySqlInfoMessageEventArgs
    begin

    end;

    trigger Conexion2MySql::StateChange(sender: Variant; e: DotNet StateChangeEventArgs) //TODO: Error: No existe el Dotnet StateChangeEventArgs
    begin

    end;

    trigger Conexion2MySql::Disposed(sender: Variant; e: DotNet EventArgs) //TODO: Error: No existe el Dotnet EventArgs
    begin

    end;

    trigger Command2MySql::Disposed(sender: Variant; e: DotNet EventArgs) //TODO: Error: No existe el Dotnet EventArgs
    begin

    end;
    */
}