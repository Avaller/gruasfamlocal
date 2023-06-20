/// <summary>
/// Page Ingestrel Setup (ID 50013).
/// </summary>
page 50013 "Ingestrel Setup"
{
    Caption = 'Ingestrel Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Ingestrel Setup_LDR";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Vehicle Book Directory"; Rec."Vehicle Book Directory")
                {
                    ApplicationArea = All;
                    Caption = 'Directorio de libros de vehículos';
                    ToolTip = 'Directorio de libros de vehículos';
                }
                field("Update Company Data"; Rec."Update Company Data")
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Datos de la Compañia';
                    ToolTip = 'Actualizar Datos de la Compañia';
                }
                field("Update Customer Data"; Rec."Update Customer Data")
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Daots del Cliente';
                    ToolTip = 'Actualizar Daots del Cliente';
                }
                field("Update Employees Data"; Rec."Update Employees Data")
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Datos de Empleados';
                    ToolTip = 'Actualizar Datos de Empleados';
                }
                field("Update Serv. Item Data"; Rec."Update Serv. Item Data")
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar datos de artículos de servicio';
                    ToolTip = 'Actualizar datos de artículos de servicio';
                }
            }
            group("MySQL Params")
            {
                Caption = 'MySQL Params';
                field("Server IP Address"; Rec."Server IP Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección IP del Servidor';
                    ToolTip = 'Dirección IP del Servidor';
                }
                field("Server TCP Port"; Rec."Server TCP Port")
                {
                    ApplicationArea = All;
                    Caption = 'Puerto TCP del servidor';
                    ToolTip = 'Puerto TCP del servidor';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Caption = 'Usuario';
                    ToolTip = 'Usuario';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    Caption = 'Contraseña';
                    ToolTip = 'Contraseña';
                }
                field(BBDD; Rec.BBDD)
                {
                    ApplicationArea = All;
                    Caption = 'BBDD';
                    ToolTip = 'BBDD';
                }
                field("Last Export Date"; Rec."Last Export Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ultima Fecha de Exportación';
                    ToolTip = 'Ultima Fecha de Exportación';
                }
            }
            group("FTP Params")
            {
                Caption = 'FTP Params';
                field("FTP Address"; Rec."FTP Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección FTP';
                    ToolTip = 'Dirección FTP';
                }
                field("FTP User"; Rec."FTP User")
                {
                    ApplicationArea = All;
                    Caption = 'Usuario FTP';
                    ToolTip = 'Usuario FTP';
                }
                field("FTP Password"; Rec."FTP Password")
                {
                    ApplicationArea = All;
                    Caption = 'Contraseña FTP';
                    ToolTip = 'Contraseña FTP';
                }
                field("FTP Directory"; Rec."FTP Directory")
                {
                    ApplicationArea = All;
                    Caption = 'Directorio FTP';
                    ToolTip = 'Directorio FTP';
                }
                field("FTP Port"; Rec."FTP Port")
                {
                    ApplicationArea = All;
                    Caption = 'Puerto FTP';
                    ToolTip = 'Puerto FTP';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}