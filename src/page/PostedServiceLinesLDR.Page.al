/// <summary>
/// Page Posted Service Lines (ID 50234).
/// </summary>
page 50234 "Posted Service Lines"
{
    // version ALQUINTA9.00

    AutoSplitKey = true;
    CaptionML = ENU = 'Service Lines',
                ESP = 'Líneas servicio';
    DataCaptionFields = "Document No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Posted Service Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field("Service Item Line No."; Rec."Service Item Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de línea de artículo de servicio';
                    ToolTip = 'Número de línea de artículo de servicio';
                    Visible = false;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de artículo de servicio';
                    ToolTip = 'Número de artículo de servicio';
                    Visible = false;
                }
                field("Service Item Serial No."; Rec."Service Item Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de serie del artículo de servicio';
                    ToolTip = 'Número de serie del artículo de servicio';
                    Visible = false;
                }
                field("Service Item Line Description"; Rec."Service Item Line Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de línea de artículo de servicio';
                    DrillDown = false;
                    ToolTip = 'Descripción de línea de artículo de servicio';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo';
                    ToolTip = 'Tipo';

                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    ToolTip = 'No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de variante';
                    ToolTip = 'Código de variante';
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    Caption = 'Agotado';
                    ToolTip = 'Agotado';
                    Visible = false;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = All;
                    Caption = 'Sustitución disponible';
                    ToolTip = 'Sustitución disponible';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción 2';
                    ToolTip = 'Descripción 2';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de localización';
                    ToolTip = 'Código de localización';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de bandeja';
                    ToolTip = 'Código de bandeja';
                    Visible = false;
                }
                field("Initial Time"; Rec."Initial Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo inicial';
                    ToolTip = 'Tiempo inicial';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización';
                    ToolTip = 'Hora de finalización';
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    Caption = 'Reservar';
                    ToolTip = 'Reservar';
                    Visible = false;
                }
                field("Internal Quantity"; Rec."Internal Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad interna';
                    ToolTip = 'Cantidad interna';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Cantidad';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de unidad de medida';
                    ToolTip = 'Código de unidad de medida';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Costo unitario (LCY)';
                    ToolTip = 'Costo unitario (LCY)';
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Precio unitario';
                    ToolTip = 'Precio unitario';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad de línea';
                    ToolTip = 'Cantidad de línea';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = '% de descuento de línea';
                    ToolTip = '% de descuento de línea';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad de descuento de línea';
                    ToolTip = 'Cantidad de descuento de línea';
                }
                field("Line Discount Type"; Rec."Line Discount Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de descuento de línea';
                    ToolTip = 'Tipo de descuento de línea';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad enviada';
                    ToolTip = 'Cantidad enviada';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad facturada';
                    ToolTip = 'Cantidad facturada';
                }
                field("Quantity Consumed"; Rec."Quantity Consumed")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Cantidad consumida';
                    ToolTip = 'Cantidad consumida';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de tipo de trabajo';
                    ToolTip = 'Código de tipo de trabajo';
                    Visible = false;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de motivo de falla';
                    ToolTip = 'Código de motivo de falla';
                    Visible = false;
                }
                field("Fault Area Code"; Rec."Fault Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de área de falla';
                    ToolTip = 'Código de área de falla';
                    Visible = "Fault Area CodeVisible";
                }
                field("Symptom Code"; Rec."Symptom Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de síntoma';
                    ToolTip = 'Código de síntoma';
                    Visible = "Symptom CodeVisible";
                }
                field("Fault Code"; Rec."Fault Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de fallo';
                    ToolTip = 'Código de fallo';
                    Visible = "Fault CodeVisible";
                }
                field("Resolution Code"; Rec."Resolution Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de resolución';
                    ToolTip = 'Código de resolución';
                    Visible = "Resolution CodeVisible";
                }
                field("Serv. Price Adjmt. Gr. Code"; Rec."Serv. Price Adjmt. Gr. Code")
                {
                    ApplicationArea = All;
                    Caption = 'serv. Ajuste de precio Gramo. Código';
                    ToolTip = 'serv. Ajuste de precio Gramo. Código';
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Caption = 'Permitir disco de factura.';
                    ToolTip = 'Permitir disco de factura.';
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    Caption = 'inversión Importe de descuento';
                    ToolTip = 'inversión Importe de descuento';
                    Visible = false;
                }
                field("Exclude Warranty"; Rec."Exclude Warranty")
                {
                    ApplicationArea = All;
                    Caption = 'Excluir garantía';
                    ToolTip = 'Excluir garantía';
                }
                field("Exclude Contract Discount"; Rec."Exclude Contract Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Excluir descuento de contrato';
                    ToolTip = 'Excluir descuento de contrato';
                }
                field("Warranty>"; Rec."Warranty>")
                {
                    ApplicationArea = All;
                    Caption = 'Garantía';
                    ToolTip = 'Garantía';
                }
                field("Warranty Disc. %"; Rec."Warranty Disc. %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Disco de garantía. %';
                    ToolTip = 'Disco de garantía. %';
                    Visible = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato';
                    Editable = false;
                    ToolTip = 'Nº de contrato';
                }
                field("Contract Disc. %"; Rec."Contract Disc. %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Disco de contrato. %';
                    ToolTip = 'Disco de contrato. %';
                    Visible = false;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'IVA %';
                    ToolTip = 'IVA %';
                    Visible = false;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Importe base del IVA';
                    ToolTip = 'Importe base del IVA';
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Importe IVA incluido';
                    ToolTip = 'Importe IVA incluido';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Autobús general. Grupo de contabilización';
                    ToolTip = 'Autobús general. Grupo de contabilización';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. gen. Grupo de contabilización';
                    ToolTip = 'Prod. gen. Grupo de contabilización';
                    Visible = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Grupo de contabilización';
                    ToolTip = 'Grupo de contabilización';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de publicación';
                    Editable = false;
                    ToolTip = 'Fecha de publicación';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de trabajo';
                    ToolTip = 'Nº de trabajo';
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Caption = 'Núm. de tarea de trabajo';
                    ToolTip = 'Núm. de tarea de trabajo';
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de línea de trabajo';
                    ToolTip = 'Tipo de línea de trabajo';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Acceso directo Código de dimensión';
                    ToolTip = 'Acceso directo Código de dimensión';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Acceso directo Código de dimensión 2';
                    ToolTip = 'Acceso directo Código de dimensión 2';
                    Visible = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cotización';
                    ToolTip = 'No de Cotización';
                    Visible = false;
                }
                field("Quote Line No."; Rec."Quote Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Línea de cotización';
                    ToolTip = 'No de Línea de cotización';
                    Visible = false;
                }
                field("Quote Invoice Line No."; Rec."Quote Invoice Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de línea de factura de cotización';
                    ToolTip = 'Número de línea de factura de cotización';
                    Visible = false;
                }
                field(Revaluation; Rec.Revaluation)
                {
                    ApplicationArea = All;
                    Caption = 'Revalorización';
                    ToolTip = 'Revalorización';
                }
                field("Item Entry No."; Rec."Item Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de entrada de artículo';
                    Editable = false;
                    ToolTip = 'Número de entrada de artículo';
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'No 2';
                    ToolTip = 'No 2';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            ESP = '&Línea';
                action(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                                ESP = 'Di&mensiones';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        CLEAR(SelectionFilter);
        SetSelectionFilter;

        ServMgtSetup.GET;
        case ServMgtSetup."Fault Reporting Level" of
            ServMgtSetup."Fault Reporting Level"::None:
                begin
                    "Fault Area CodeVisible" := FALSE;
                    "Symptom CodeVisible" := FALSE;
                    "Fault CodeVisible" := FALSE;
                    "Resolution CodeVisible" := FALSE;
                end;
            ServMgtSetup."Fault Reporting Level"::Fault:
                begin
                    "Fault Area CodeVisible" := FALSE;
                    "Symptom CodeVisible" := FALSE;
                    "Fault CodeVisible" := TRUE;
                    "Resolution CodeVisible" := TRUE;
                end;
            ServMgtSetup."Fault Reporting Level"::"Fault+Symptom":
                begin
                    "Fault Area CodeVisible" := FALSE;
                    "Symptom CodeVisible" := TRUE;
                    "Fault CodeVisible" := TRUE;
                    "Resolution CodeVisible" := TRUE;
                end;
            ServMgtSetup."Fault Reporting Level"::"Fault+Symptom+Area (IRIS)":
                begin
                    "Fault Area CodeVisible" := TRUE;
                    "Symptom CodeVisible" := TRUE;
                    "Fault CodeVisible" := TRUE;
                    "Resolution CodeVisible" := TRUE;
                end;
        end;
    end;

    var
        Text008: TextConst ENU = 'You cannot open the window because %1 is %2 in the %3 table.', ESP = 'No puede abrir la ventana porque %1 es %2 en la tabla %3.';
        ServMgtSetup: Record "Service Mgt. Setup";
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        SalesPriceCalcMgt: Codeunit "Price Calculation Mgt.";
        ServInfoPaneMgt: Codeunit "Service Info-Pane Management";
        ShortcutDimCode: array[8] of Code[20];
        ServItemLineNo: Integer;
        SelectionFilter: Option "All Service Lines","Lines per Selected Service Item","Lines Not Item Related";
        Text011: TextConst ENU = 'This will reset all price adjusted lines to default values. Continue?', ESP = 'Esto restablecerá todas las líns. ajuste precio a valores genéricos. ¿Desea continuar?';
        ServiceInvLine: Record "Service Line";
        ServiceItemLine: Record "Service Item Line";
        [InDataSet]
        "Fault Area CodeVisible": BoolEAN;
        [InDataSet]
        "Symptom CodeVisible": BoolEAN;
        [InDataSet]
        "Fault CodeVisible": BoolEAN;
        [InDataSet]
        "Resolution CodeVisible": BoolEAN;

    /// <summary>
    /// CalcInvDisc.
    /// </summary>
    /// <param name="ServLine">VAR Record "Service Line".</param>
    procedure CalcInvDisc(var ServLine: Record "Service Line");
    begin
        CODEUNIT.RUN(CODEUNIT::"Service-Calc. Discount", ServLine);
    end;

    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="ServItemLine">Integer.</param>
    procedure Initialize(ServItemLine: Integer);
    begin
        ServItemLineNo := ServItemLine;
    end;

    /// <summary>
    /// SetSelectionFilter.
    /// </summary>
    procedure SetSelectionFilter();
    begin
        case SelectionFilter of
            SelectionFilter::"All Service Lines":
                Rec.SETRANGE(Rec."Service Item Line No.");
            SelectionFilter::"Lines per Selected Service Item":
                Rec.SETRANGE(Rec."Service Item Line No.", ServItemLineNo);
            SelectionFilter::"Lines Not Item Related":
                Rec.SETRANGE(Rec."Service Item Line No.", 0);
        end;
        CurrPage.UPDATE(FALSE);
    end;

    /// <summary>
    /// InfopaneEnable.
    /// </summary>
    /// <param name="Value">BoolEAN.</param>
    procedure InfopaneEnable(Value: BoolEAN);
    begin
    end;

    local procedure TypeOnAfterValidate();
    begin
        InfopaneEnable((Rec.Type = Rec.Type::Item) AND (Rec."No." <> ''));
    end;

    local procedure SelectionFilterOnAfterValidate();
    begin
        CurrPage.UPDATE;
        SetSelectionFilter;
    end;
}

