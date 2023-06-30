/// <summary>
/// PageExtension Employee Card_LDR (ID 50091) extends Record Employee Card.
/// </summary>
pageextension 50091 "Employee Card_LDR" extends "Employee Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Visa Card_LDR"; Rec."Visa Card_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tarjeta Visa';
                ToolTip = 'Tarjeta Visa';
            }
            field(Creditor_LDR; Rec.Creditor_LDR)
            {
                ApplicationArea = All;
                Caption = 'Acreedor';
                ToolTip = 'Acreedor';
            }
            field("Expenses Account_LDR"; Rec."Expenses Account_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cuenta de gastos';
                ToolTip = 'Cuenta de gastos';
            }
            field("Avoid Expenses_LDR"; Rec."Avoid Expenses_LDR")
            {
                ApplicationArea = All;
                Caption = 'Evite gastos';
                ToolTip = 'Evite gastos';
            }
            group(Schedule)
            {
                Caption = 'Horario';
            }
            field("Journey Starting Time_LDR"; Rec."Journey Starting Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de inicio del viaje';
                ToolTip = 'Hora de inicio del viaje';
            }
            field("Journey Ending Time_LDR"; Rec."Journey Ending Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización del viaje';
                ToolTip = 'Hora de finalización del viaje';
            }
        }
        addafter("Resource No.")
        {
            field("Company Dependence_LDR"; Rec."Company Dependence_LDR")
            {
                ApplicationArea = All;
                Caption = 'Dependencia de la empresa';
                ToolTip = 'Dependencia de la empresa';
            }
        }
        addafter("Salespers./Purch. Code")
        {
            group("Ingestrel Params")
            {
                Caption = 'Parametros Ingestrel';
            }
            field("Ingestrel Export_LDR"; Rec."Ingestrel Export_LDR")
            {
                ApplicationArea = All;
                Caption = 'Exportación de Ingestrel';
                ToolTip = 'Exportación de Ingestrel';

                trigger OnValidate()
                begin
                    if not Rec."Ingestrel Export_LDR" then
                        Error(Text50003);
                end;
            }
            field("Employment Date2"; Rec."Employment Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha empleo';
                Importance = Promoted;
                ToolTip = 'Fecha empleo';
            }
            field("VAT Registration No._LDR"; Rec."VAT Registration No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field(Name2; Rec.Name)
            {
                ApplicationArea = All;
                Caption = 'Nombre';
                Importance = Promoted;
                ToolTip = 'Nombre';
            }
            field("First Family Name2"; Rec."First Family Name")
            {
                ApplicationArea = All;
                Caption = 'Primer apellido';
                ToolTip = 'Primer apellido';
            }
            field("Second Family Name2"; Rec."Second Family Name")
            {
                ApplicationArea = All;
                Caption = 'Segundo apellido';
                ToolTip = 'Segundo apellido';
            }
            field("Mobile Phone No.2"; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Número de teléfono móvil';
                Importance = Promoted;
                ToolTip = 'Número de teléfono móvil';
            }
            field("Phone No.3"; Rec."Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Telefono no.';
                ToolTip = 'Telefono no.';
            }
            field("E-Mail2"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'E-Mail';
                Importance = Promoted;
                ToolTip = 'E-Mail';
            }
            field("Fax No."; Rec."Fax No.")
            {
                ApplicationArea = All;
                Caption = 'Número de fax.';
                ToolTip = 'Número de fax.';
            }
            field("Job Title2"; Rec."Job Title")
            {
                ApplicationArea = All;
                Caption = 'Título profesional';
                Importance = Promoted;
                ToolTip = 'Título profesional';
            }
            field("Last Export Date_LDR"; Rec."Last Export Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Última fecha de exportación';
                Editable = false;
                ToolTip = 'Última fecha de exportación';
            }
            field("Extranet Deletion_LDR"; Rec."Extranet Deletion_LDR")
            {
                ApplicationArea = All;
                Caption = 'Eliminación de extranet';
                ToolTip = 'Eliminación de extranet';
            }
        }
        addafter("Union Membership No.")
        {
            field("Tag Card No._LDR"; Rec."Tag Card No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Nro. de tarjeta de etiqueta';
                ToolTip = 'Nro. de tarjeta de etiqueta';
            }
        }
    }

    actions
    {
        addafter(PayEmployee)
        {
            group(History_LDR)
            {
                Caption = 'Historial';
            }
            action("Employee Marking Entries")
            {
                ApplicationArea = All;
                Caption = 'Marcajes de empleado';
                Image = EmployeeAgreement;

                RunObject = Page "Employee Marking Entries";
                RunPageLink = "Operation Employee Code" = field("No.");
            }
            action("Displacement Entries")
            {
                ApplicationArea = All;
                Caption = 'Movimientos Desplazamiento';
                Image = WIPEntries;

                //RunObject = Page 50079;
                //RunPageLink = "Employee No." = FIELD("No.");
            }
            group(Expenses)
            {
                Caption = 'Gastos';
                Image = Planning;
            }
            action("Expenses Types")
            {
                ApplicationArea = All;
                Caption = 'Tipos de Gasto';

                RunObject = Page "Empl. Expenses Types";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            group(Ingestrel)
            {
                Caption = 'Ingestrel';
            }
            action("View Links")
            {
                ApplicationArea = All;
                Caption = 'Ver Adjuntos';
                Image = Links;

                trigger OnAction()
                var
                    RecordLink: Record "Record Link";
                    pLinks: Page "Service Item Bin Entry";
                begin
                    RecordLink.SETRANGE("Record ID", Rec.RecordId);
                    RecordLink.SETRANGE(Type, RecordLink.Type::Link);
                    CLEAR(pLinks);
                    pLinks.SETTABLEVIEW(RecordLink);
                    //pLinks.SetParams(Rec.RecordId);
                    pLinks.RUNMODAL;
                end;
            }
            action("Set Delete from Extranet")
            {
                ApplicationArea = All;
                Caption = 'Marcar para eliminaci¢n en Ingestrel';
                Image = RemoveContacts;

                trigger OnAction()
                begin
                    Rec.TestField("Ingestrel Export_LDR");
                    Rec.TestField("Last Export Date_LDR");
                    if Confirm(Text50001, false) then begin
                        Rec."Extranet Deletion_LDR" := TRUE;
                        Rec.MODIFY(TRUE);
                    end;
                end;
            }
        }
    }

    var
        Text50001: Label 'Esta seguro de querer establecer este registro para su eliminaci¢n de Ingestrel?';
        Text50003: Label 'Debe utilizar el proceso de Eliminacion de Ingestrel.';

}