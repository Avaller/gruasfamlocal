/// <summary>
/// Codeunit Copy Serv. Rate Mgt._LDR (ID 50005)
/// </summary>
codeunit 50005 "Copy Serv. Rate Mgt._LDR"
{
    TableNo = "Service Item Rate Header_LDR";

    trigger OnRun()
    begin

        CopyServRateHeader(Rec);
    end;

    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
        Text001: Label 'Copy of: ';
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";

    /// <summary>
    /// CopyServRateHeader()
    /// </summary>
    procedure CopyServRateHeader(tempServRateHeader: Record "Service Item Rate Header_LDR")
    var
        newHeader: Record "Service Item Rate Header_LDR";
        SelectedNoSeries: Code[20];
        NoSeriesRelationship: Record "No. Series Relationship";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        //copiar entre empresas
        CraneMgtSetup.GET;

        CLEAR(ServiceItemRateHeader);
        ServiceItemRateHeader := tempServRateHeader;

        ServiceItemRateHeader.Code := '';

        // Permitir seleccionar la serie cuando exista mas de una
        CLEAR(NoSeriesRelationship);
        NoSeriesRelationship.SETRANGE(NoSeriesRelationship.Code, CraneMgtSetup."Service Item Tariff Nos.");
        IF NoSeriesRelationship.FINDFIRST THEN BEGIN
            IF SelectedNoSeries = '' THEN BEGIN
                IF NoSeriesMgt.SelectSeries(CraneMgtSetup."Service Item Tariff Nos.", ServiceItemRateHeader."No. Series", ServiceItemRateHeader."No. Series") THEN BEGIN
                    SelectedNoSeries := ServiceItemRateHeader."No. Series";
                    ServiceItemRateHeader.VALIDATE("No. Series", SelectedNoSeries);
                END ELSE
                    ERROR('');
            END ELSE BEGIN
                ServiceItemRateHeader.VALIDATE("No. Series", SelectedNoSeries);
            END;
        END;

        NoSeriesMgt.InitSeries(CraneMgtSetup."Service Item Tariff Nos.", '', tempServRateHeader.NewInitialdate, ServiceItemRateHeader.Code, ServiceItemRateHeader."No. Series");

        ServiceItemRateHeader."Valid Start Date" := tempServRateHeader.NewInitialdate;
        ServiceItemRateHeader."Valid End Date" := tempServRateHeader.NewEndingDate;

        ServiceItemRateHeader."Source Code" := tempServRateHeader.Code;
        ServiceItemRateHeader.Status := ServiceItemRateHeader.Status::Open;
        ServiceItemRateHeader.Description := COPYSTR(Text001 + ServiceItemRateHeader.Description, 1, 50);
        ServiceItemRateHeader.INSERT(TRUE);

        CopyServRateResLine(tempServRateHeader, ServiceItemRateHeader);
        CopyServRateCraneLine(tempServRateHeader, ServiceItemRateHeader);
        CopyServRatePlatfLine(tempServRateHeader, ServiceItemRateHeader);
    end;

    /// <summary>
    /// CopyServRateResLine()
    /// </summary>
    local procedure CopyServRateResLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRateResLine: Record "Servic Item Rat Lin - Res_LDR";
        newServRateResLine: Record "Servic Item Rat Lin - Res_LDR";
    begin
        //Copiar entre empresas
        CLEAR(sourceServRateResLine);
        sourceServRateResLine.CHANGECOMPANY(tempHeader.SourceCompany);
        sourceServRateResLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRateResLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(newServRateResLine);
                newServRateResLine := sourceServRateResLine;
                newServRateResLine.Code := newHeader.Code;
                newServRateResLine."Resource Group No." := sourceServRateResLine."Resource Group No.";
                newServRateResLine."Min Hours" := ROUND(sourceServRateResLine."Min Hours", 0.01);
                newServRateResLine."Price Hour" := ROUND(sourceServRateResLine."Price Hour" * tempHeader.ResourcePriceFactor, 0.01);
                newServRateResLine.INSERT(TRUE);
            UNTIL sourceServRateResLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CopyServRateCraneLine()
    /// </summary>
    local procedure CopyServRateCraneLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRateCraneLine: Record "Servic Item Rat Li - Crane_LDR";
        newServRateCraneLine: Record "Servic Item Rat Li - Crane_LDR";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
    begin

        CLEAR(sourceServRateCraneLine);
        sourceServRateCraneLine.CHANGECOMPANY(tempHeader.SourceCompany);
        sourceServRateCraneLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRateCraneLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(newServRateCraneLine);
                newServRateCraneLine := sourceServRateCraneLine;
                newServRateCraneLine.Code := newHeader.Code;
                newServRateCraneLine."Invoice Group No." := sourceServRateCraneLine."Invoice Group No.";
                newServRateCraneLine."Min working Time" := sourceServRateCraneLine."Min working Time";

                ServiceItemInvoiceGroup.GET(sourceServRateCraneLine."Invoice Group No.");
                CASE ServiceItemInvoiceGroup."Rate Type" OF
                    ServiceItemInvoiceGroup."Rate Type"::"crane-100":
                        BEGIN
                            newServRateCraneLine."KM Price" := ROUND(sourceServRateCraneLine."KM Price" * tempHeader.SmallCranePriceFactor, 0.01);
                            newServRateCraneLine."Hour Price" := ROUND(sourceServRateCraneLine."Hour Price" * tempHeader.SmallCranePriceFactor, 0.01);
                            newServRateCraneLine."Stop Hour Price" := ROUND(sourceServRateCraneLine."Stop Hour Price" * tempHeader.SmallCranePriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::"crane+100":
                        BEGIN
                            newServRateCraneLine."KM Price" := ROUND(sourceServRateCraneLine."KM Price" * tempHeader.BigCranePriceFactor, 0.01);
                            newServRateCraneLine."Hour Price" := ROUND(sourceServRateCraneLine."Hour Price" * tempHeader.BigCranePriceFactor, 0.01);
                            newServRateCraneLine."Stop Hour Price" := ROUND(sourceServRateCraneLine."Stop Hour Price" * tempHeader.BigCranePriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::cranetruck:
                        BEGIN
                            newServRateCraneLine."KM Price" := ROUND(sourceServRateCraneLine."KM Price" * tempHeader.CraneTruckPriceFactor, 0.01);
                            newServRateCraneLine."Hour Price" := ROUND(sourceServRateCraneLine."Hour Price" * tempHeader.CraneTruckPriceFactor, 0.01);
                            newServRateCraneLine."Stop Hour Price" := ROUND(sourceServRateCraneLine."Stop Hour Price" * tempHeader.CraneTruckPriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::truck:
                        BEGIN
                            newServRateCraneLine."KM Price" := ROUND(sourceServRateCraneLine."KM Price" * tempHeader.TruckPriceFactor, 0.01);
                            newServRateCraneLine."Hour Price" := ROUND(sourceServRateCraneLine."Hour Price" * tempHeader.TruckPriceFactor, 0.01);
                            newServRateCraneLine."Stop Hour Price" := ROUND(sourceServRateCraneLine."Stop Hour Price" * tempHeader.TruckPriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::platform:
                        BEGIN
                            newServRateCraneLine."KM Price" := ROUND(sourceServRateCraneLine."KM Price" * tempHeader.PlatformPriceFactor, 0.01);
                            newServRateCraneLine."Hour Price" := ROUND(sourceServRateCraneLine."Hour Price" * tempHeader.PlatformPriceFactor, 0.01);
                            newServRateCraneLine."Stop Hour Price" := ROUND(sourceServRateCraneLine."Stop Hour Price" * tempHeader.PlatformPriceFactor, 0.01);
                        END;
                END;
                newServRateCraneLine.INSERT(TRUE);
            UNTIL sourceServRateCraneLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CopyServRatePlatfLine()
    /// </summary>
    local procedure CopyServRatePlatfLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRatePlatfLine: Record "Servic Item Rat Lin - Plat_LDR";
        newServRateResPlatfLine: Record "Servic Item Rat Lin - Plat_LDR";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
    begin
        CLEAR(sourceServRatePlatfLine);
        sourceServRatePlatfLine.CHANGECOMPANY(tempHeader.SourceCompany);
        sourceServRatePlatfLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRatePlatfLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(newServRateResPlatfLine);
                newServRateResPlatfLine := sourceServRatePlatfLine;
                newServRateResPlatfLine.Code := newHeader.Code;
                newServRateResPlatfLine."Invoice Group No." := sourceServRatePlatfLine."Invoice Group No.";

                ServiceItemInvoiceGroup.GET(sourceServRatePlatfLine."Invoice Group No.");
                CASE ServiceItemInvoiceGroup."Rate Type" OF
                    ServiceItemInvoiceGroup."Rate Type"::"crane-100":
                        BEGIN
                            newServRateResPlatfLine."KM Price" := ROUND(sourceServRatePlatfLine."KM Price" * tempHeader.SmallCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Day Cost" := ROUND(sourceServRatePlatfLine."Day Cost" * tempHeader.SmallCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Mouth Cost" := ROUND(sourceServRatePlatfLine."Mouth Cost" * tempHeader.SmallCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Year Cost" := ROUND(sourceServRatePlatfLine."Year Cost" * tempHeader.SmallCranePriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::"crane+100":
                        BEGIN
                            newServRateResPlatfLine."KM Price" := ROUND(sourceServRatePlatfLine."KM Price" * tempHeader.BigCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Day Cost" := ROUND(sourceServRatePlatfLine."Day Cost" * tempHeader.BigCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Mouth Cost" := ROUND(sourceServRatePlatfLine."Mouth Cost" * tempHeader.BigCranePriceFactor, 0.01);
                            newServRateResPlatfLine."Year Cost" := ROUND(sourceServRatePlatfLine."Year Cost" * tempHeader.BigCranePriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::cranetruck:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := ROUND(sourceServRatePlatfLine."KM Price" * tempHeader.CraneTruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Day Cost" := ROUND(sourceServRatePlatfLine."Day Cost" * tempHeader.CraneTruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Mouth Cost" := ROUND(sourceServRatePlatfLine."Mouth Cost" * tempHeader.CraneTruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Year Cost" := ROUND(sourceServRatePlatfLine."Year Cost" * tempHeader.CraneTruckPriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::truck:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := ROUND(sourceServRatePlatfLine."KM Price" * tempHeader.TruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Day Cost" := ROUND(sourceServRatePlatfLine."Day Cost" * tempHeader.TruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Mouth Cost" := ROUND(sourceServRatePlatfLine."Mouth Cost" * tempHeader.TruckPriceFactor, 0.01);
                            newServRateResPlatfLine."Year Cost" := ROUND(sourceServRatePlatfLine."Year Cost" * tempHeader.TruckPriceFactor, 0.01);
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::platform:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := ROUND(sourceServRatePlatfLine."KM Price" * tempHeader.PlatformPriceFactor, 0.01);
                            newServRateResPlatfLine."Day Cost" := ROUND(sourceServRatePlatfLine."Day Cost" * tempHeader.PlatformPriceFactor, 0.01);
                            newServRateResPlatfLine."Mouth Cost" := ROUND(sourceServRatePlatfLine."Mouth Cost" * tempHeader.PlatformPriceFactor, 0.01);
                            newServRateResPlatfLine."Year Cost" := ROUND(sourceServRatePlatfLine."Year Cost" * tempHeader.PlatformPriceFactor, 0.01);
                        END;
                END;
                newServRateResPlatfLine.INSERT(TRUE);
            UNTIL sourceServRatePlatfLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CopyLocalServRateHeader()
    /// </summary>
    procedure CopyLocalServRateHeader(tempServRateHeader: Record "Service Item Rate Header_LDR")
    var
        newHeader: Record "Service Item Rate Header_LDR";
        SelectedNoSeries: Code[20];
        NoSeriesRelationship: Record "No. Series Relationship";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        //copiar entre empresas
        CraneMgtSetup.GET;
        CLEAR(ServiceItemRateHeader);
        ServiceItemRateHeader := tempServRateHeader;

        ServiceItemRateHeader.Code := '';

        // Permitir seleccionar la serie cuando exista mas de una
        CLEAR(NoSeriesRelationship);
        NoSeriesRelationship.SETRANGE(NoSeriesRelationship.Code, CraneMgtSetup."Service Item Tariff Nos.");
        IF NoSeriesRelationship.FINDFIRST THEN BEGIN
            IF SelectedNoSeries = '' THEN BEGIN
                IF NoSeriesMgt.SelectSeries(CraneMgtSetup."Service Item Tariff Nos.", ServiceItemRateHeader."No. Series", ServiceItemRateHeader."No. Series") THEN BEGIN
                    SelectedNoSeries := ServiceItemRateHeader."No. Series";
                    ServiceItemRateHeader.VALIDATE("No. Series", SelectedNoSeries);
                END ELSE
                    ERROR('');
            END ELSE BEGIN
                ServiceItemRateHeader.VALIDATE("No. Series", SelectedNoSeries);
            END;
        END;

        NoSeriesMgt.InitSeries(CraneMgtSetup."Service Item Tariff Nos.", '', tempServRateHeader.NewInitialdate, ServiceItemRateHeader.Code, ServiceItemRateHeader."No. Series");

        ServiceItemRateHeader."Valid Start Date" := tempServRateHeader.NewInitialdate;
        ServiceItemRateHeader."Valid End Date" := tempServRateHeader.NewEndingDate;


        ServiceItemRateHeader."Source Code" := tempServRateHeader.Code;
        ServiceItemRateHeader.Status := ServiceItemRateHeader.Status::Open;
        ServiceItemRateHeader.Description := COPYSTR(Text001 + ServiceItemRateHeader.Description, 1, 50);
        ServiceItemRateHeader.INSERT(TRUE);

        CopyServRateResLine(tempServRateHeader, ServiceItemRateHeader);
        CopyServRateCraneLine(tempServRateHeader, ServiceItemRateHeader);
        CopyServRatePlatfLine(tempServRateHeader, ServiceItemRateHeader);
    end;

    /// <summary>
    /// CopyLocalServRateResLine()
    /// </summary>
    local procedure CopyLocalServRateResLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRateResLine: Record "Servic Item Rat Lin - Res_LDR";
        newServRateResLine: Record "Servic Item Rat Lin - Res_LDR";
    begin
        //Copiar entre empresas
        CLEAR(sourceServRateResLine);
        sourceServRateResLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRateResLine.FINDSET THEN BEGIN
            REPEAT
                CLEAR(newServRateResLine);
                newServRateResLine.Code := newHeader.Code;
                newServRateResLine."Resource Group No." := sourceServRateResLine."Resource Group No.";
                newServRateResLine."Min Hours" := sourceServRateResLine."Min Hours";
                newServRateResLine."Price Hour" := sourceServRateResLine."Price Hour" * tempHeader.ResourcePriceFactor;
                newServRateResLine.INSERT(TRUE);
            UNTIL sourceServRateResLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CopyLocalServRateCraneLine()
    /// </summary>
    local procedure CopyLocalServRateCraneLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRateCraneLine: Record "Servic Item Rat Li - Crane_LDR";
        newServRateCraneLine: Record "Servic Item Rat Li - Crane_LDR";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
    begin

        CLEAR(sourceServRateCraneLine);
        sourceServRateCraneLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRateCraneLine.FINDSET THEN BEGIN
            REPEAT
                newServRateCraneLine.Code := newHeader.Code;
                newServRateCraneLine."Invoice Group No." := sourceServRateCraneLine."Invoice Group No.";
                newServRateCraneLine."Min working Time" := sourceServRateCraneLine."Min working Time";

                ServiceItemInvoiceGroup.GET(sourceServRateCraneLine."Invoice Group No.");
                CASE ServiceItemInvoiceGroup."Rate Type" OF
                    ServiceItemInvoiceGroup."Rate Type"::"crane-100":
                        BEGIN
                            newServRateCraneLine."KM Price" := sourceServRateCraneLine."KM Price" * tempHeader.SmallCranePriceFactor;
                            newServRateCraneLine."Hour Price" := sourceServRateCraneLine."Hour Price" * tempHeader.SmallCranePriceFactor;
                            newServRateCraneLine."Stop Hour Price" := sourceServRateCraneLine."Stop Hour Price" * tempHeader.SmallCranePriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::"crane+100":
                        BEGIN
                            newServRateCraneLine."KM Price" := sourceServRateCraneLine."KM Price" * tempHeader.BigCranePriceFactor;
                            newServRateCraneLine."Hour Price" := sourceServRateCraneLine."Hour Price" * tempHeader.BigCranePriceFactor;
                            newServRateCraneLine."Stop Hour Price" := sourceServRateCraneLine."Stop Hour Price" * tempHeader.BigCranePriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::cranetruck:
                        BEGIN
                            newServRateCraneLine."KM Price" := sourceServRateCraneLine."KM Price" * tempHeader.CraneTruckPriceFactor;
                            newServRateCraneLine."Hour Price" := sourceServRateCraneLine."Hour Price" * tempHeader.CraneTruckPriceFactor;
                            newServRateCraneLine."Stop Hour Price" := sourceServRateCraneLine."Stop Hour Price" * tempHeader.CraneTruckPriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::truck:
                        BEGIN
                            newServRateCraneLine."KM Price" := sourceServRateCraneLine."KM Price" * tempHeader.TruckPriceFactor;
                            newServRateCraneLine."Hour Price" := sourceServRateCraneLine."Hour Price" * tempHeader.TruckPriceFactor;
                            newServRateCraneLine."Stop Hour Price" := sourceServRateCraneLine."Stop Hour Price" * tempHeader.TruckPriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::platform:
                        BEGIN
                            newServRateCraneLine."KM Price" := sourceServRateCraneLine."KM Price" * tempHeader.PlatformPriceFactor;
                            newServRateCraneLine."Hour Price" := sourceServRateCraneLine."Hour Price" * tempHeader.PlatformPriceFactor;
                            newServRateCraneLine."Stop Hour Price" := sourceServRateCraneLine."Stop Hour Price" * tempHeader.PlatformPriceFactor;
                        END;
                END;
                newServRateCraneLine.INSERT(TRUE);
            UNTIL sourceServRateCraneLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// CopyLocalServRatePlatfLine()
    /// </summary>
    local procedure CopyLocalServRatePlatfLine(tempHeader: Record "Service Item Rate Header_LDR"; newHeader: Record "Service Item Rate Header_LDR")
    var
        sourceServRatePlatfLine: Record "Servic Item Rat Lin - Plat_LDR";
        newServRateResPlatfLine: Record "Servic Item Rat Lin - Plat_LDR";
        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
    begin
        CLEAR(sourceServRatePlatfLine);
        sourceServRatePlatfLine.SETRANGE(Code, tempHeader.Code);
        IF sourceServRatePlatfLine.FINDSET THEN BEGIN
            REPEAT
                newServRateResPlatfLine.Code := newHeader.Code;
                newServRateResPlatfLine."Invoice Group No." := sourceServRatePlatfLine."Invoice Group No.";

                ServiceItemInvoiceGroup.GET(sourceServRatePlatfLine."Invoice Group No.");
                CASE ServiceItemInvoiceGroup."Rate Type" OF
                    ServiceItemInvoiceGroup."Rate Type"::"crane-100":
                        BEGIN
                            newServRateResPlatfLine."KM Price" := sourceServRatePlatfLine."KM Price" * tempHeader.SmallCranePriceFactor;
                            newServRateResPlatfLine."Day Cost" := sourceServRatePlatfLine."Day Cost" * tempHeader.SmallCranePriceFactor;
                            newServRateResPlatfLine."Mouth Cost" := sourceServRatePlatfLine."Mouth Cost" * tempHeader.SmallCranePriceFactor;
                            newServRateResPlatfLine."Year Cost" := sourceServRatePlatfLine."Year Cost" * tempHeader.SmallCranePriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::"crane+100":
                        BEGIN
                            newServRateResPlatfLine."KM Price" := sourceServRatePlatfLine."KM Price" * tempHeader.BigCranePriceFactor;
                            newServRateResPlatfLine."Day Cost" := sourceServRatePlatfLine."Day Cost" * tempHeader.BigCranePriceFactor;
                            newServRateResPlatfLine."Mouth Cost" := sourceServRatePlatfLine."Mouth Cost" * tempHeader.BigCranePriceFactor;
                            newServRateResPlatfLine."Year Cost" := sourceServRatePlatfLine."Year Cost" * tempHeader.BigCranePriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::cranetruck:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := sourceServRatePlatfLine."KM Price" * tempHeader.CraneTruckPriceFactor;
                            newServRateResPlatfLine."Day Cost" := sourceServRatePlatfLine."Day Cost" * tempHeader.CraneTruckPriceFactor;
                            newServRateResPlatfLine."Mouth Cost" := sourceServRatePlatfLine."Mouth Cost" * tempHeader.CraneTruckPriceFactor;
                            newServRateResPlatfLine."Year Cost" := sourceServRatePlatfLine."Year Cost" * tempHeader.CraneTruckPriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::truck:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := sourceServRatePlatfLine."KM Price" * tempHeader.TruckPriceFactor;
                            newServRateResPlatfLine."Day Cost" := sourceServRatePlatfLine."Day Cost" * tempHeader.TruckPriceFactor;
                            newServRateResPlatfLine."Mouth Cost" := sourceServRatePlatfLine."Mouth Cost" * tempHeader.TruckPriceFactor;
                            newServRateResPlatfLine."Year Cost" := sourceServRatePlatfLine."Year Cost" * tempHeader.TruckPriceFactor;
                        END;
                    ServiceItemInvoiceGroup."Rate Type"::platform:
                        BEGIN
                            newServRateResPlatfLine."KM Price" := sourceServRatePlatfLine."KM Price" * tempHeader.PlatformPriceFactor;
                            newServRateResPlatfLine."Day Cost" := sourceServRatePlatfLine."Day Cost" * tempHeader.PlatformPriceFactor;
                            newServRateResPlatfLine."Mouth Cost" := sourceServRatePlatfLine."Mouth Cost" * tempHeader.PlatformPriceFactor;
                            newServRateResPlatfLine."Year Cost" := sourceServRatePlatfLine."Year Cost" * tempHeader.PlatformPriceFactor;
                        END;
                END;
                newServRateResPlatfLine.INSERT(TRUE);
            UNTIL sourceServRatePlatfLine.NEXT = 0;
        END;
    end;
}