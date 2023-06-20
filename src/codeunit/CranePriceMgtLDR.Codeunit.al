/// <summary>
/// Codeunit Crane Price Mgt._LDR (ID 50007)
/// </summary>
codeunit 50007 "Crane Price Mgt._LDR"
{
    // Esta codeunit englobara las funciones que permitirán obtener los precios corerspondientes a cada actividad del vertical de maquinaria
    // adaptado para Gruas FAM

    trigger OnRun()
    begin
    end;

    var
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        Text001: Label 'UOM %1 isn''t setup as a valid UOM in %2';

    /// <summary>
    /// GetDisplacementPrice()
    /// </summary>
    procedure GetDisplacementPrice(pServInvGroupCode: Code[10]; pServRateHeader: Record "Service Item Rate Header_LDR"; pPriceType: Option KMs,Hours): Decimal
    var
        RateInvGrLine: Record "Servic Item Rat Li - Crane_LDR";
    begin
        CLEAR(RateInvGrLine);

        RateInvGrLine.SETRANGE(Code, pServRateHeader.Code);
        RateInvGrLine.SETRANGE("Invoice Group No.", pServInvGroupCode);
        RateInvGrLine.FINDFIRST;

        IF pPriceType = pPriceType::Hours THEN
            EXIT(RateInvGrLine."Hour Price")
        ELSE
            IF pPriceType = pPriceType::KMs THEN
                EXIT(RateInvGrLine."KM Price");
    end;

    /// <summary>
    /// GetExtraOperatorHourPrice()
    /// </summary>
    procedure GetExtraOperatorHourPrice(pResourceCode: Code[20]; pCraneQuoteHeader: Record "Crane Service Quote Header_LDR"; pServRateHeader: Record "Service Item Rate Header_LDR"; pUOM: Code[10]): Decimal
    var
        RateInvResLine: Record "Servic Item Rat Lin - Res_LDR";
        Resource: Record "Resource";
    begin
        CraneMgtSetup.GET;

        Resource.GET(pResourceCode);

        CLEAR(RateInvResLine);

        RateInvResLine.SETRANGE(Code, pServRateHeader.Code);
        RateInvResLine.SETRANGE("Resource Group No.", Resource."Resource Group No.");
        RateInvResLine.FINDFIRST;

        CASE pUOM OF
            CraneMgtSetup."Daytime Workday UOM":
                BEGIN
                    EXIT(RateInvResLine."Price Hour");
                END;
            CraneMgtSetup."Nighttime Workday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                        EXIT(RateInvResLine."Price Night Hour");
                    END ELSE BEGIN
                        EXIT(RateInvResLine."Price Hour");
                    END;
                END;
            CraneMgtSetup."Daytime Saturday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Saturday Surcharge" THEN BEGIN
                        EXIT(RateInvResLine."Price Saturday Hour");
                    END ELSE BEGIN
                        EXIT(RateInvResLine."Price Hour");
                    END;
                END;
            CraneMgtSetup."Nighttime Saturday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Saturday Surcharge" THEN BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateInvResLine."Price Saturday Night Hour");
                        END ELSE BEGIN
                            EXIT(RateInvResLine."Price Saturday Hour");
                        END;
                    END ELSE BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateInvResLine."Price Night Hour");
                        END ELSE BEGIN
                            EXIT(RateInvResLine."Price Hour");
                        END;
                    END;
                END;
            CraneMgtSetup."Daytime Holiday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Festive Surcharge" THEN BEGIN
                        EXIT(RateInvResLine."Price Holiday Hour");
                    END ELSE BEGIN
                        EXIT(RateInvResLine."Price Hour");
                    END;
                END;
            CraneMgtSetup."Nighttime Holiday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Festive Surcharge" THEN BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateInvResLine."Price Holiday Night");
                        END ELSE BEGIN
                            EXIT(RateInvResLine."Price Holiday Hour");
                        END;
                    END ELSE BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateInvResLine."Price Night Hour");
                        END ELSE BEGIN
                            EXIT(RateInvResLine."Price Hour");
                        END;
                    END;
                END;
        END;

        //Si llega hasta aqui, es que no ha encontrado nada.
        //En ese caso, devolvemos el precio configurado para el recurso en su ficha.
        EXIT(Resource."Unit Price");
    end;

    /// <summary>
    /// GetCraneHourPrice()
    /// </summary>
    procedure GetCraneHourPrice(pServItemInvGrCode: Code[20]; pCraneQuoteHeader: Record "Crane Service Quote Header_LDR"; pServRateHeader: Record "Service Item Rate Header_LDR"; pUOM: Code[10]): Decimal
    var
        RateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
    begin
        CraneMgtSetup.GET;

        CLEAR(RateLineCrane);

        RateLineCrane.SETRANGE(Code, pServRateHeader.Code);
        RateLineCrane.SETRANGE("Invoice Group No.", pServItemInvGrCode);
        RateLineCrane.FINDFIRST;

        CASE pUOM OF
            CraneMgtSetup."Daytime Workday UOM":
                BEGIN
                    EXIT(RateLineCrane."Hour Price");
                END;
            CraneMgtSetup."Nighttime Workday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                        EXIT(RateLineCrane."Night Hour Price");
                    END ELSE BEGIN
                        EXIT(RateLineCrane."Hour Price");
                    END;
                END;
            CraneMgtSetup."Daytime Saturday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Saturday Surcharge" THEN BEGIN
                        EXIT(RateLineCrane."Saturday Hour Price");
                    END ELSE BEGIN
                        EXIT(RateLineCrane."Hour Price");
                    END;
                END;
            CraneMgtSetup."Nighttime Saturday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Saturday Surcharge" THEN BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateLineCrane."Saturday Nigth Hour Price");
                        END ELSE BEGIN
                            EXIT(RateLineCrane."Saturday Hour Price");
                        END;
                    END ELSE BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateLineCrane."Night Hour Price");
                        END ELSE BEGIN
                            EXIT(RateLineCrane."Hour Price");
                        END;
                    END;
                END;
            CraneMgtSetup."Daytime Holiday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Festive Surcharge" THEN BEGIN
                        EXIT(RateLineCrane."Holiday Hour Price");
                    END ELSE BEGIN
                        EXIT(RateLineCrane."Hour Price");
                    END;
                END;
            CraneMgtSetup."Nighttime Holiday UOM":
                BEGIN
                    IF pCraneQuoteHeader."Apply Festive Surcharge" THEN BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateLineCrane."Holiday Night Hour Price");
                        END ELSE BEGIN
                            EXIT(RateLineCrane."Holiday Hour Price");
                        END;
                    END ELSE BEGIN
                        IF pCraneQuoteHeader."Apply Night Surcharge" THEN BEGIN
                            EXIT(RateLineCrane."Night Hour Price");
                        END ELSE BEGIN
                            EXIT(RateLineCrane."Hour Price");
                        END;
                    END;
                END;
        END;

        //Si llega hasta aqui, es que no ha encontrado nada.
        //en este caso doy error.

        ERROR(Text001, pUOM, CraneMgtSetup.TABLECAPTION);
    end;

    /// <summary>
    /// GetExitFeePrice()
    /// </summary>
    procedure GetExitFeePrice(pServInvGroupCode: Code[10]; pServRateHeader: Record "Service Item Rate Header_LDR"): Decimal
    var
        RateInvGrLine: Record "Servic Item Rat Li - Crane_LDR";
    begin
        CLEAR(RateInvGrLine);

        RateInvGrLine.SETRANGE(Code, pServRateHeader.Code);
        RateInvGrLine.SETRANGE("Invoice Group No.", pServInvGroupCode);
        RateInvGrLine.FINDFIRST;

        //Pendiente implementar la eleccion de distintos conceptos de salida.

        EXIT(RateInvGrLine."Exit Fee Price")
    end;
}