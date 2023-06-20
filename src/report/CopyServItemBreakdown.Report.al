report 50002 "Copy Serv. Item Breakdown"
{
    // version FAM

    CaptionML = ENU = 'Copy Service Item Breakdown',
                ESP = 'Copiar Despiece de Producto de Servicio';
    ProcessingOnly = true;

    /*
    dataset
    {
        dataitem(DataItem1000000000;Table2000000026)
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;

            trigger OnAfterGetRecord();
            var
                fromServItemBD : Record "50026";
                toServItemBD : Record "50026";
                toServItemBreakdown : Record "50018";
            begin
                // CLEAR(ServiceItemBreakdown);
                // ServiceItemBreakdown.SETRANGE(Default,TRUE);
                // ServiceItemBreakdown.FINDFIRST;

                IF bNewDetail THEN BEGIN
                  CLEAR(toServItemBreakdown);
                  toServItemBreakdown.Code := TargetManufacturer;
                  toServItemBreakdown."Model No." := TargetModel;
                  toServItemBreakdown.INSERT;
                  COMMIT;
                END;

                CLEAR(fromServItemBD);
                fromServItemBD.SETRANGE("Manufacturer Code",ServiceItemBreakdown.Code);
                fromServItemBD.SETRANGE("Model Code",ServiceItemBreakdown."Model No.");
                IF NOT bCopyItemDetail THEN
                  fromServItemBD.SETFILTER(Identation,'<>%1',2);
                IF fromServItemBD.FINDSET THEN BEGIN
                  REPEAT
                    CLEAR(toServItemBD);
                    //"Manufacturer Code","Model Code","Breakdown Category Code","Breakdown SubCategory Code","Item No."
                    IF NOT toServItemBD.GET(TargetManufacturer,
                                            TargetModel,
                                            fromServItemBD."Breakdown Category Code",
                                            fromServItemBD."Breakdown SubCategory Code",
                                            fromServItemBD."Item No.") THEN BEGIN
                      toServItemBD."Manufacturer Code" := TargetManufacturer;
                      toServItemBD."Model Code" := TargetModel;
                      toServItemBD."Breakdown Category Code" := fromServItemBD."Breakdown Category Code";
                      toServItemBD."Breakdown SubCategory Code" := fromServItemBD."Breakdown SubCategory Code";
                      toServItemBD."Item No." := fromServItemBD."Item No.";
                      toServItemBD.INSERT(TRUE);
                    END;

                    IF fromServItemBD.Identation IN [0,1] THEN
                      CounterCategory += 1
                    ELSE IF fromServItemBD.Identation = 2 THEN
                      CounterItem += 1;
                  UNTIL fromServItemBD.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem();
            begin

                IF bCopyItemDetail THEN
                  MESSAGE('Se han copiado %1 categorias/subcategorias y %2 Detalles de producto',CounterCategory,CounterItem)
                ELSE
                  MESSAGE('Se han copiado %1 categorias/subcategorias',CounterCategory);
            end;

            trigger OnPreDataItem();
            begin
                IF bNewDetail AND ((TargetManufacturer = '') OR (TargetModel = '')) THEN
                  ERROR(Text001);

                IF (SourceManufacturer = '') OR (SourceModel = '') THEN
                  ERROR(Text004);

                IF ServiceItemBreakdown.GET(TargetManufacturer,TargetModel) AND bNewDetail THEN
                  ERROR(Text002);

                // CLEAR(ServiceItemBreakdown);
                // ServiceItemBreakdown.SETRANGE(Default,TRUE);
                IF NOT ServiceItemBreakdown.GET(SourceManufacturer,SourceModel) THEN
                  ERROR(Text003);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Source)
                {
                    CaptionML = ENU='Source',
                                ESP='Origen';
                    grid()
                    {
                        GridLayout = Rows;
                        group()
                        {
                            field(SourceManufacturer;SourceManufacturer)
                            {
                                CaptionML = ENU='Source Manufacturer Code',
                                            ESP='Cód. Fabricante Origen';
                                TableRelation = Manufacturer.Code;

                                trigger OnValidate();
                                begin
                                    SourceModel := '';
                                end;
                            }
                            field(SourceModel;SourceModel)
                            {
                                CaptionML = ENU='Source Model Code',
                                            ESP='Cód. Modelo Origen';

                                trigger OnLookup(Text : Text) : BoolEAN;
                                var
                                    rServItemModel : Record "50007";
                                    pServItemModel : Page "50007";
                                begin
                                    IF SourceManufacturer <> '' THEN BEGIN
                                      rServItemModel.SETRANGE(Code,SourceManufacturer);
                                      pServItemModel.SETTABLEVIEW(rServItemModel);
                                      pServItemModel.LOOKUPMODE(TRUE);
                                      IF pServItemModel.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        pServItemModel.GETRECORD(rServItemModel);
                                        SourceModel := rServItemModel."Model Code";
                                      END;
                                    END;
                                end;
                            }
                        }
                    }
                }
                group(Target)
                {
                    CaptionML = ENU='Target',
                                ESP='Destino';
                    Editable = bNewDetail;
                    Visible = bNewDetail;
                    grid()
                    {
                        GridLayout = Rows;
                        group()
                        {
                            field(TargetManufacturer;TargetManufacturer)
                            {
                                CaptionML = ENU='Target Manufacturer Code',
                                            ESP='Cód. Fabricante Destino';
                                TableRelation = Manufacturer.Code;

                                trigger OnValidate();
                                begin
                                    TargetModel := '';
                                end;
                            }
                            field(TargetModel;TargetModel)
                            {
                                CaptionML = ENU='Target Model Code',
                                            ESP='Cód. Modelo Destino';

                                trigger OnLookup(Text : Text) : BoolEAN;
                                var
                                    rServItemModel : Record "50007";
                                    pServItemModel : Page "50007";
                                begin
                                    IF TargetManufacturer <> '' THEN BEGIN
                                      rServItemModel.SETRANGE(Code,TargetManufacturer);
                                      pServItemModel.SETTABLEVIEW(rServItemModel);
                                      pServItemModel.LOOKUPMODE(TRUE);
                                      IF pServItemModel.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        pServItemModel.GETRECORD(rServItemModel);
                                        TargetModel := rServItemModel."Model Code";
                                      END;
                                    END;
                                end;
                            }
                        }
                    }
                }
                group(General)
                {
                    CaptionML = ENU='General',
                                ESP='General';
                    field(bCopyItemDetail;bCopyItemDetail)
                    {
                        CaptionML = ENU='Copy Item Details',
                                    ESP='Copiar Detalle de Productos';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }
    */
    var
        SourceManufacturer: Code[10];
        SourceModel: Code[10];
        TargetManufacturer: Code[10];
        TargetModel: Code[10];
        Text001: TextConst ENU = 'You must choose a Target Manufacturer Code and Target Model Code in order to continue.', ESP = 'Debe seleccionar Cod. Fabricante Destino y Cod. Modelo Destino para poder continuar.';
        bCopyItemDetail: BoolEAN;
        [InDataSet]
        bNewDetail: BoolEAN;
        Text002: TextConst ENU = 'The selected Serv. Item Breakdown already exist. Please, use the "Update from.." functionality instead.', ESP = 'El Despiece de Prod. Servicio seleccionado ya existe. Por favor, utilice la funcionalidad "Actualizar desde.." en su lugar.';
        Text003: TextConst ENU = 'You must define a Default Service Item Breakdown first', ESP = 'Debe definir un Despiece por Defecto primero.';
        ServiceItemBreakdown: Record "Service Item Breakdown_LDR";
        CounterCategory: Integer;
        CounterItem: Integer;
        Text004: TextConst ENU = 'You must choose a Source Manufacturer Code and Source Model Code in order to continue.', ESP = 'Debe seleccionar Cod. Fabricante Origen y Cod. Modelo Origen para poder continuar.';

    procedure SetValues(pNewDetail: BoolEAN; pManufacturerCode: Code[10]; pModelCode: Code[10]);
    begin
        bNewDetail := pNewDetail;
        TargetManufacturer := pManufacturerCode;
        TargetModel := pModelCode;
    end;

    procedure EnableTargetSelection() flag: BoolEAN;
    begin
        EXIT(bNewDetail);
    end;

}

