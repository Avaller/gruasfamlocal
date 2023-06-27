/// <summary>
/// tableextension 50006 "Item_LDR"
/// </summary>
tableextension 50006 "Item_LDR" extends "Item"
{
    fields
    {
        field(50000; Type2_LDR; Option)
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
            Description = 'Tipo Pieza';
            OptionCaption = '" ",Componente,Implemento,Repuesto,Máquina';
            OptionMembers = " ",Component,Implement,"Spare Part",Machine;

            trigger OnValidate()
            begin
                if Type2_LDR <> Type2_LDR::Component then begin
                    Subtype_LDR := Subtype_LDR::" ";
                end;
                InicializarCaracteristicas(Type2_LDR, Subtype_LDR);
            end;
        }
        field(50001; Subtype_LDR; Option)
        {
            Caption = 'Tipo Componente';
            DataClassification = ToBeClassified;
            Description = 'Subtipo Pieza';
            OptionCaption = '" ",Chasis,Mástil,Motor,Ruedas,Horquillas,Batería,Cargador';
            OptionMembers = " ",Chasis,Mast,Engine,Wheels,Brackets,Batery,Charger;

            trigger OnValidate()
            begin
                if (Subtype_LDR <> Subtype_LDR::" ") and (Type2_LDR <> Type2_LDR::Component) then
                    Error(TextSubTipo, FieldCaption(Subtype_LDR));

                InicializarCaracteristicas(Type2_LDR, Subtype_LDR);
            end;
        }
        field(50002; Model_LDR; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50003; "Item Type_LDR"; Text[50])
        {
            Caption = 'Tipo Producto';
            DataClassification = ToBeClassified;
            Description = 'Tipo Producto';
            //TableRelation = Table70023.Field2 WHERE (Field1=FIELD(Subtype)); 
        }
        field(50004; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50005; "Series Code_LDR"; Code[20])
        {
            Caption = 'Código de Serie';
            DataClassification = ToBeClassified;
            Description = 'Indica el Código de la Serie';
            //TableRelation = Table70005; 
        }
        field(50006; "Medea Code_LDR"; Code[20])
        {
            Caption = 'Código de Clasificación Medea';
            DataClassification = ToBeClassified;
            Description = 'Indica el Código de Clasificacion Medea';
            //TableRelation = Table70007; 
        }
        field(50007; "Valid For_LDR"; Text[50])
        {
            Caption = 'Válido para';
            DataClassification = ToBeClassified;
            Description = 'Válido para';
        }
        field(50008; Characteristics_LDR; Text[50])
        {
            Caption = 'Características';
            DataClassification = ToBeClassified;
            Description = 'Características';
        }
        field(50009; "Large Description_LDR"; Text[100])
        {
            Caption = 'Descripción Larga';
            DataClassification = ToBeClassified;
            Description = 'Descripcion Larga del Producto de Servicio';
        }
        field(50010; "No. 2 Series_LDR"; Code[10])
        {
            Caption = 'Nos. 2 serie';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50011; Height_LDR; Decimal)
        {
            Caption = 'Altura (mm)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Description = 'Indica la Longitud (mm)';
        }
        field(50012; Folded_LDR; Decimal)
        {
            Caption = 'Replegado (mm)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Description = 'Indica el Replegado (mm)';
        }
        field(50013; "Exclude armopa_LDR"; Boolean)
        {
            Caption = 'Excluir Armopa';
            DataClassification = ToBeClassified;
            Description = 'Tipo Pieza';
        }
        field(50014; "Free Elevation_LDR"; Decimal)
        {
            Caption = 'Elevación Libre (mm)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Description = 'Indica la Elevación Libre';
        }
        field(50015; "Wheels front measures_LDR"; Text[50])
        {
            Caption = 'Medidas Delanteras';
            DataClassification = ToBeClassified;
            Description = 'Medidas Delanteras';
        }
        field(50016; "Wheels rear measures_LDR"; Text[50])
        {
            Caption = 'Medidas Traseras';
            DataClassification = ToBeClassified;
            Description = 'Medidas Traseras';
        }
        field(50017; Volt_LDR; Text[50])
        {
            Caption = 'Voltaje';
            DataClassification = ToBeClassified;
            Description = 'Voltaje';
        }
        field(50018; Amp_LDR; Text[50])
        {
            Caption = 'Amperaje';
            DataClassification = ToBeClassified;
            Description = 'Amperaje';
        }
        field(50019; Plates_LDR; Integer)
        {
            Caption = 'Placas';
            DataClassification = ToBeClassified;
            Description = 'Placas';
        }
        field(50020; "Bracket Length_LDR"; Integer)
        {
            Caption = 'Longitud Horquilla (mm)';
            DataClassification = ToBeClassified;
            Description = 'Longitud Horquilla (mm)';
        }
        field(50021; "Bracket Gross_LDR"; Integer)
        {
            Caption = 'Grosor Horquilla (mm)';
            DataClassification = ToBeClassified;
            Description = 'Grosor Horquilla (mm)';
        }
        field(50022; "Bracket Width_LDR"; Integer)
        {
            Caption = 'Ancho Horquilla (mm)';
            DataClassification = ToBeClassified;
            Description = 'Ancho Horquilla (mm)';
        }
        field(50023; EAN_LDR; Code[20])
        {
            Caption = 'EAN';
            DataClassification = ToBeClassified;
            Description = 'Codigo EAN';

            trigger OnValidate()
            var
                recItem: Record "Item";
                //FuncionesEAN: Codeunit 70018;
                CheckEAN: Code[20];
            begin
                if (EAN_LDR <> '') and (Rec.EAN_LDR <> xRec.EAN_LDR) then begin
                    Clear(recItem);
                    recItem.SetCurrentKey(EAN_LDR);
                    recItem.SetRange(recItem.EAN_LDR, EAN_LDR);
                    if recItem.FindFirst then
                        Error(TextEANerror, EAN_LDR);

                    if StrLen(EAN_LDR) <> 13 then
                        Error(TextEANIncorrecto, EAN_LDR);

                    //CheckEAN := FuncionesEAN.ObtenerDC(CopyStr(EAN_LDR, 1, (StrLen(EAN_LDR) - 1)));
                    if CheckEAN <> EAN_LDR then
                        Error(TextDCIncorrecto, EAN_LDR);
                END;
            end;
        }
        field(50024; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50025; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50026; "LDR_Inventory_LDR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"),
            "Variant Code" = FIELD("Variant Filter"), "Lot No." = FIELD("Lot No. Filter"), "Serial No." = FIELD("Serial No. Filter"),
            "Posting Date" = FIELD("Date Filter")));
        }
    }

    keys
    {
        key(Key20; EAN_LDR)
        {

        }
        key(Key21; "No. 2")
        {

        }
    }

    fieldgroups
    {
        addlast(DropDown; "No. 2")
        { }
    }

    trigger OnAfterModify()
    begin
        Rec."Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        ServiceItem: Record "Service Item Line";
        ItemBudgetEntry: Record "Item Budget Entry";
        ItemSub: Record "Item Substitution";
        CommentLine: Record "Comment Line";
        ItemVend: Record "Item Vendor";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        PurchPrice: Record "Purchase Price";
        PurchLineDisc: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        ItemTranslation: Record "Item Translation";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemVariant: Record "Item Variant";
        ExtTextHeader: Record "Extended Text Header";
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        ItemAnalysisBudgViewEntry: Record "Item Analysis View Budg. Entry";
        PlanningAssignment: Record "Planning Assignment";
        BOMComp: Record "BOM Component";
        TroubleshSetup: Record "Troubleshooting Setup";
        ResSkillMgt: Codeunit "Resource Skill Mgt.";
        ItemIdent: Record "Item Identifier";
        ServiceItemComponent: Record "Service Item Component";
    begin
        if Companies.FindSet() then begin
            repeat
                ServiceItem.ChangeCompany(Companies.Name);

                ItemBudgetEntry.ChangeCompany(Companies.Name);
                ItemBudgetEntry.SetCurrentKey("Analysis Area", "Budget Name", "Item No.");
                ItemBudgetEntry.SetRange("Item No.", "No.");
                ItemBudgetEntry.DeleteAll(true);

                ItemSub.Reset();
                ItemSub.ChangeCompany(Companies.Name);
                ItemSub.SetRange(Type, ItemSub.Type::Item);
                ItemSub.SetRange("No.", "No.");
                ItemSub.DeleteAll();

                ItemSub.Reset();
                ItemSub.ChangeCompany(Companies.Name);
                ItemSub.SetRange("Substitute Type", ItemSub."Substitute Type"::Item);
                ItemSub.SetRange("Substitute No.", "No.");
                ItemSub.DeleteAll();

                SKU.Reset();
                SKU.ChangeCompany(Companies.Name);
                SKU.SetCurrentKey("Item No.");
                SKU.SetRange("Item No.", "No.");
                SKU.DeleteAll();

                CommentLine.ChangeCompany(Companies.Name);
                CommentLine.SetRange("Table Name", CommentLine."Table Name"::Item);
                CommentLine.SetRange("No.", "No.");
                CommentLine.DeleteAll();

                ItemVend.ChangeCompany(Companies.Name);
                ItemVend.SetCurrentKey("Item No.");
                ItemVend.SetRange("Item No.", "No.");
                ItemVend.DeleteAll();

                SalesPrice.ChangeCompany(Companies.Name);
                SalesPrice.SetRange("Item No.", "No.");
                SalesPrice.DeleteAll();

                SalesLineDisc.ChangeCompany(Companies.Name);
                SalesLineDisc.SetRange(Type, SalesLineDisc.Type::Item);
                SalesLineDisc.SetRange(Code, "No.");
                SalesLineDisc.DeleteAll();

                SalesPrepmtPct.ChangeCompany(Companies.Name);
                SalesPrepmtPct.SetRange("Item No.", "No.");
                SalesPrepmtPct.DeleteAll();

                PurchPrice.ChangeCompany(Companies.Name);
                PurchPrice.SetRange("Item No.", "No.");
                PurchPrice.DeleteAll();

                PurchLineDisc.ChangeCompany(Companies.Name);
                PurchLineDisc.SetRange("Item No.", "No.");
                PurchLineDisc.DeleteAll();

                PurchPrepmtPct.ChangeCompany(Companies.Name);
                PurchPrepmtPct.SetRange("Item No.", "No.");
                PurchPrepmtPct.DeleteAll();

                ItemTranslation.ChangeCompany(Companies.Name);
                ItemTranslation.SetRange("Item No.", "No.");
                ItemTranslation.DeleteAll();

                ItemUnitOfMeasure.ChangeCompany(Companies.Name);
                ItemUnitOfMeasure.SetRange("Item No.", "No.");
                ItemUnitOfMeasure.DeleteAll();

                ItemVariant.ChangeCompany(Companies.Name);
                ItemVariant.SetRange("Item No.", "No.");
                ItemVariant.DeleteAll();

                ExtTextHeader.ChangeCompany(Companies.Name);
                ExtTextHeader.SetRange("Table Name", ExtTextHeader."Table Name"::Item);
                ExtTextHeader.SetRange("No.", "No.");
                ExtTextHeader.DeleteAll(true);

                ItemAnalysisViewEntry.ChangeCompany(Companies.Name);
                ItemAnalysisViewEntry.SetRange("Item No.", "No.");
                ItemAnalysisViewEntry.DeleteAll();

                ItemAnalysisBudgViewEntry.ChangeCompany(Companies.Name);
                ItemAnalysisBudgViewEntry.SetRange("Item No.", "No.");
                ItemAnalysisBudgViewEntry.DeleteAll();

                PlanningAssignment.ChangeCompany(Companies.Name);
                PlanningAssignment.SetRange("Item No.", "No.");
                PlanningAssignment.DeleteAll();

                BOMComp.Reset();
                BOMComp.ChangeCompany(Companies.Name);
                BOMComp.SetRange("Parent Item No.", "No.");
                BOMComp.DeleteAll();

                TroubleshSetup.Reset();
                TroubleshSetup.ChangeCompany(Companies.Name);
                TroubleshSetup.SetRange(Type, TroubleshSetup.Type::Item);
                TroubleshSetup.SetRange("No.", "No.");
                TroubleshSetup.DeleteAll();

                ResSkillMgt.DeleteItemResSkills("No.");

                ItemIdent.Reset();
                ItemIdent.ChangeCompany(Companies.Name);
                ItemIdent.SetCurrentKey("Item No.");
                ItemIdent.SetRange("Item No.", "No.");
                ItemIdent.DeleteAll();

                ServiceItemComponent.Reset();
                ServiceItemComponent.ChangeCompany(Companies.Name);
                ServiceItemComponent.SetRange(Type, ServiceItemComponent.Type::Item);
                ServiceItemComponent.SetRange("No.", "No.");
                ServiceItemComponent.ModifyAll("No.", '');

            until Companies.Next() = 0;
        end;
    end;

    var
        TextSubTipo: TextConst ENU = '%1 can be modified only on Component items', ESP = '%1 solo puede ser modificado para productos de tipo Componente';
        TextEANerror: TextConst ENU = 'Already exist an item with the EAN code %1', ESP = 'Ya existe un producto con el EAN %1';
        TextEANIncorrecto: TextConst ENU = 'The EAN %1 must be 13 digits', ESP = 'El EAN %1 debe tener 13 dígitos';
        TextDCIncorrecto: TextConst ENU = 'The code %1 it is not an correct EAN', ESP = 'El código %1 no es un EAN correcto';
        Companies: Record "Company";
        SKU: Record "Stockkeeping Unit";

    procedure InicializarCaracteristicas(Tipo: Option " ",Component,Implement,"Spare Part",Machine; Subtipo: Option " ",Chasis,Mast,Engine,Wheels,Brackets,Batery,Charger);
    begin
        case Tipo of
            Tipo::Component:
                begin
                    ;
                    case SubTipo of
                        SubTipo::Chasis:
                            begin
                                "Item Type_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                "Valid For_LDR" := '';
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                        SubTipo::Mast:
                            begin
                                "Item Type_LDR" := '';
                                Model_LDR := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                "Free Elevation_LDR" := 0;
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                        SubTipo::Engine:
                            begin
                                "Item Type_LDR" := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                "Valid For_LDR" := '';
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                        SubTipo::Wheels:
                            begin
                                "Item Type_LDR" := '';
                                Model_LDR := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                "Valid For_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                        SubTipo::Brackets:
                            begin
                                "Item Type_LDR" := '';
                                Model_LDR := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                "Valid For_LDR" := '';
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                        SubTipo::Batery:
                            begin
                                "Item Type_LDR" := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                            end;
                        SubTipo::Charger:
                            begin
                                "Item Type_LDR" := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                Plates_LDR := 0;
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                            end;
                        SubTipo::" ":
                            begin
                                "Item Type_LDR" := '';
                                Model_LDR := '';
                                "Series Code_LDR" := '';
                                "Charge Capacity_LDR" := 0;
                                Height_LDR := 0;
                                Folded_LDR := 0;
                                "Free Elevation_LDR" := 0;
                                "Valid For_LDR" := '';
                                Characteristics_LDR := '';
                                "Wheels front measures_LDR" := '';
                                "Wheels rear measures_LDR" := '';
                                "Bracket Length_LDR" := 0;
                                "Bracket Width_LDR" := 0;
                                "Bracket Gross_LDR" := 0;
                                Plates_LDR := 0;
                                Volt_LDR := '';
                                Amp_LDR := '';
                            end;
                    end;
                end;
            Tipo::Implement:
                begin
                    "Item Type_LDR" := '';
                    "Charge Capacity_LDR" := 0;
                    Height_LDR := 0;
                    Folded_LDR := 0;
                    "Free Elevation_LDR" := 0;
                    "Valid For_LDR" := '';
                    Characteristics_LDR := '';
                    "Wheels front measures_LDR" := '';
                    "Wheels rear measures_LDR" := '';
                    "Bracket Length_LDR" := 0;
                    "Bracket Width_LDR" := 0;
                    "Bracket Gross_LDR" := 0;
                    Plates_LDR := 0;
                    Volt_LDR := '';
                    Amp_LDR := '';

                end;
            Tipo::"Spare Part":
                begin
                    "Item Type_LDR" := '';
                    Model_LDR := '';
                    "Series Code_LDR" := '';
                    "Charge Capacity_LDR" := 0;
                    Height_LDR := 0;
                    Folded_LDR := 0;
                    "Free Elevation_LDR" := 0;
                    "Valid For_LDR" := '';
                    Characteristics_LDR := '';
                    "Wheels front measures_LDR" := '';
                    "Wheels rear measures_LDR" := '';
                    "Bracket Length_LDR" := 0;
                    "Bracket Width_LDR" := 0;
                    "Bracket Gross_LDR" := 0;
                    Plates_LDR := 0;
                    Volt_LDR := '';
                    Amp_LDR := '';

                end;
            Tipo::Machine:
                begin
                    "Item Type_LDR" := '';
                    Height_LDR := 0;
                    Folded_LDR := 0;
                    "Free Elevation_LDR" := 0;
                    "Valid For_LDR" := '';
                    Characteristics_LDR := '';
                    "Wheels front measures_LDR" := '';
                    "Wheels rear measures_LDR" := '';
                    "Bracket Length_LDR" := 0;
                    "Bracket Width_LDR" := 0;
                    "Bracket Gross_LDR" := 0;
                    Plates_LDR := 0;
                    Volt_LDR := '';
                    Amp_LDR := '';

                end;
            Tipo
            ::" ":
                begin
                    "Item Type_LDR" := '';
                    Model_LDR := '';
                    "Series Code_LDR" := '';
                    "Charge Capacity_LDR" := 0;
                    Height_LDR := 0;
                    Folded_LDR := 0;
                    "Free Elevation_LDR" := 0;
                    "Valid For_LDR" := '';
                    Characteristics_LDR := '';
                    "Wheels front measures_LDR" := '';
                    "Wheels rear measures_LDR" := '';
                    "Bracket Length_LDR" := 0;
                    "Bracket Width_LDR" := 0;
                    "Bracket Gross_LDR" := 0;
                    Plates_LDR := 0;
                    Volt_LDR := '';
                    Amp_LDR := '';
                end;
        end;
    end;

    procedure AssignNo2();
    var
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        TestField("No. 2", '');
        InvSetup.Get();
        InvSetup.TestField(InvSetup."Item Nos. 2_LDR");
        NoSeriesMgt.InitSeries(InvSetup."Item Nos. 2_LDR", xRec."No. 2 Series_LDR", 0D, "No. 2", "No. 2 Series_LDR");
        Modify(true);
    end;

    procedure GenerateDelivery();
    var
        //TempLinDiarioMovimiento : Record 70066;
        //LinDiarioMovimiento : Record 70066;
        Contador: Integer;
        //JournalBatch : Record 70065;
        DocNo: Code[20];
        SourceCodeSetup: Record "Source Code Setup";
        ServSetup: Record "Service Mgt. Setup";
        frmJournal: Page "Item Bin Entry Journal";
    begin
        ServSetup.Get;
        ServSetup.TestField(ServSetup."No. Internal Vendor_LDR");

        /*if not GetJournalBatch('ITEMENTRY', JournalBatch) then
            Error('');

        Clear(TempLinDiarioMovimiento);
        TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Template Name",
           'ITEMENTRY');
        TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
        if TempLinDiarioMovimiento.FindLast() then;

        if JournalBatch."No. Series" = '' then begin
            DocNo := '';
        end else begin
            Clear(NoSeriesMgt);
            DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WorkDate)
        end;

        Clear(LinDiarioMovimiento);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Template Name",
          'ITEMENTRY');
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Batch Name", JournalBatch.Name);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Line No.", TempLinDiarioMovimiento."Line No." + 10000);
        LinDiarioMovimiento.Insert(true);

        LinDiarioMovimiento.Validate("Entry Type", LinDiarioMovimiento."Entry Type"::"0");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Posting Date", WorkDate);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Document No.", DocNo);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Item No.", "No.");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento.Description, Description);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Originally Vendor", ServSetup."No. Internal Vendor");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento.Printed, false);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."User Id", UserId);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 1 Code",
                                     "Global Dimension 1 Code");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 2 Code",
                                     "Global Dimension 2 Code");
        LinDiarioMovimiento.CreateDim(Database::Item, "No.", 0, '');
        LinDiarioMovimiento.Modify(true);*/

        Clear(frmJournal);
        //frmJournal.ShowSection(JournalBatch.Name);
        frmJournal.Run;
    end;

    procedure GenerateCollection();
    var
        //TempLinDiarioMovimiento : Record 70066;
        //LinDiarioMovimiento : Record 70066;
        //JournalBatch : Record 70065;
        ServSetup: Record "Service Mgt. Setup";
        frmJournal: Page "Item Bin Entry Journal";
    begin
        ServSetup.Get();
        ServSetup.TestField(ServSetup."No. Internal Vendor_LDR");

        /* if not GetJournalBatch('ITEMENTRY',JournalBatch) then
          Error('');

        Clear(TempLinDiarioMovimiento);
        TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Template Name",
           'ITEMENTRY');
        TempLinDiarioMovimiento.SetRange(TempLinDiarioMovimiento."Journal Batch Name",JournalBatch.Name);
        if TempLinDiarioMovimiento.FindLast() then;

        if JournalBatch."No. Series" = '' then begin
          DocNo := '';
        end else begin
          Clear(NoSeriesMgt);
          DocNo := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series",WorkDate)
        end;

        Clear(LinDiarioMovimiento);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Template Name",
          'ITEMENTRY');
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Journal Batch Name",JournalBatch.Name);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Line No.",TempLinDiarioMovimiento."Line No." + 10000);
        LinDiarioMovimiento.Insert(true);

        LinDiarioMovimiento.Validate("Entry Type",LinDiarioMovimiento."Entry Type"::"1");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Posting Date",WorkDate);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Document No.",DocNo);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Item No.","No.");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento.Description,Description);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Assignment Vendor",ServSetup."No. Internal Vendor");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento.Printed,false);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."User Id",UserId);
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 1 Code",
                                     "Global Dimension 1 Code");
        LinDiarioMovimiento.Validate(LinDiarioMovimiento."Global Dimension 2 Code",
                                     "Global Dimension 2 Code");
        LinDiarioMovimiento.CreateDim(Database::Item,"No.",0,'');
        LinDiarioMovimiento.Modify(true); */

        Clear(frmJournal);
        //frmJournal.ShowSection(JournalBatch.Name);
        frmJournal.Run;
    end;

    procedure GetJournalBatch(TemplateName: Code[20] /*; var SelectedJournalBatch: Record 70065*/): BoolEAN;
    var
    //frmJournalBatch : Page 70100;
    begin
        /* Clear(SelectedJournalBatch);
        SelectedJournalBatch.SetRange("Journal Template Name", TemplateName);
        SelectedJournalBatch.FindSet();
        Clear(frmJournalBatch);
        frmJournalBatch.LookupMode(true);
        frmJournalBatch.SetTableView(SelectedJournalBatch);
        if frmJournalBatch.RunModal = Action::LookupOK then begin
            frmJournalBatch.GetRecord(SelectedJournalBatch); 
            exit(true);
        end else begin
            exit(false);
        end; */
    end;

    procedure ProdOrderExistCompany(Company: Text[80]): BoolEAN;
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.ChangeCompany(Company);
        ProdOrderLine.SetCurrentKey(Status, "Item No.");
        ProdOrderLine.SetFilter(Status, '..%1', ProdOrderLine.Status::Released);
        ProdOrderLine.SetRange("Item No.", "No.");
        if not ProdOrderLine.IsEmpty then
            exit(true);
        exit(false);
    end;
}