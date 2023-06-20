/// <summary>
/// 
/// 
/// </summary>
page 50022 "Insert Quote"
{
    Caption = 'Insert Quote';
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = NavigatePage;
    SourceTable = "Quote Start Temp_LDR";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Step1)
            {
                Caption = 'Step 1';
                InstructionalText = 'Wizard to create quotes.';
                Visible = bStep1Visible;
                field("Machine Quote Type"; Rec."Machine Quote Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de cotización de máquina';
                    ToolTip = 'Tipo de cotización de máquina';
                }
            }
            group(Step2)
            {
                Caption = 'Step 2';
                Visible = bStep2Visible;
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    ToolTip = 'No de Cliente';

                    trigger OnValidate()
                    begin
                        CurrPage.update;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Cliente';
                    ToolTip = 'Nombre de Cliente';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Contacto';
                    ToolTip = 'No de Contacto';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Contacto';
                    ToolTip = 'Nombre de Contacto';
                }
                field("Ship-to Address Code"; Rec."Ship-to Address Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dirección de envío';
                    ToolTip = 'Código de dirección de envío';

                    trigger OnValidate()
                    begin
                        CurrPage.update;
                    end;
                }
                field("Ship-to Address Name"; Rec."Ship-to Address Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de la dirección de envío';
                    ToolTip = 'Nombre de la dirección de envío';
                }
                field("Quote Type"; Rec."Quote Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de cotización';
                    Enabled = bQuoteTypeEnabled;
                    ToolTip = 'Tipo de cotización';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Inicio';
                    ToolTip = 'Fecha de Inicio';
                }
                field("ending Date"; Rec."ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Finalización';
                    ToolTip = 'Fecha de Finalización';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Back)
            {
                Caption = '&Back';
                Enabled = bBackEnable;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    ShowStep(false);
                    PerformPrevWizardStatus;
                    ShowStep(true);
                    CurrPage.update(true)
                end;
            }
            action(Next)
            {
                Caption = '&Next';
                Enabled = bNextEnable;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    CheckStatus;
                    ShowStep(false);
                    PerformNextWizardStatus;
                    ShowStep(true);
                    CurrPage.update(true);
                end;
            }
            action(Finish)
            {
                Caption = '&Finish';
                Enabled = bFinishEnable;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction()
                var
                    "Count": Integer;
                    ServiceQuoteMgt: Codeunit "Service Quote Mgt._LDR";
                begin
                    // Crear oferta
                    if Rec."Machine Quote Type" = Rec."Machine Quote Type"::Crane then
                        ServiceQuoteMgt.CreateCraneQuote(Rec)
                    else
                        if Rec."Machine Quote Type" = Rec."Machine Quote Type"::Platform then
                            ServiceQuoteMgt.CreatePlatformQuoteOLD(Rec);

                    CurrPage.close;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        bNextEnable := true;
        WizzardStep := WizzardStep::"1";
        ShowStep(true);
    end;

    trigger OnOpenPage()
    begin
        updateEditable;
        Rec."Quote Type" := Rec."Quote Type"::Tariff;

        ShowStep(true);
    end;

    var
        [InDataSet]
        bStep1Visible: Boolean;
        [InDataSet]
        bStep2Visible: Boolean;
        [InDataSet]
        bFinishEnable: Boolean;
        [InDataSet]
        bBackEnable: Boolean;
        [InDataSet]
        bNextEnable: Boolean;
        WizzardStep: Option " ","1","2","3","4","5","6";
        ServiceQuoteMgt: Codeunit "Service Quote Mgt._LDR";
        Text001: Label 'General Purpose Quote Nr. %1 has been completed with the Default Rate Set Up';
        bQuoteTypeEnabled: Boolean;

    local procedure ShowStep(Visible: Boolean)
    begin
        case WizzardStep of
            WizzardStep::"1":
                begin
                    bStep1Visible := Visible;
                    if Visible then begin
                        bFinishEnable := false;
                        bBackEnable := false;
                        bNextEnable := true;
                    end;
                end;
            WizzardStep::"2":
                begin
                    bStep2Visible := Visible;
                    if Visible then begin
                        bFinishEnable := true;
                        bBackEnable := true;
                        bNextEnable := false;

                    end;
                end;
        end;
    end;

    local procedure PerformPrevWizardStatus()
    begin
        WizzardStep := WizzardStep - 1;
    end;

    procedure CheckStatus()
    begin
        case WizzardStep of
            WizzardStep::"1":
                begin

                end;
            WizzardStep::"2":
                begin

                end;

        end;
    end;

    procedure PerformNextWizardStatus()
    var
        Cont: Record Contact;
    begin
        WizzardStep := WizzardStep + 1;

        if WizzardStep = WizzardStep::"2" then begin
            //  if "Machine Quote Type" = "Machine Quote Type"::Platform then begin
            //    bQuoteTypeEnabled := true;
            //    "Quote Type":= "Quote Type"::Tariff;
            //  end else
            bQuoteTypeEnabled := true;
            Rec."Quote Type" := Rec."Quote Type"::Tariff;
        end;
    end;

    local procedure updateEditable()
    begin
    end;
}