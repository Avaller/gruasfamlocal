report 50027 "Get Serv Rate Crane Groups"
{
    // version FAM

    CaptionML = ENU = 'Load Serv. Rate into Crane Quote',
                ESP = 'Volcar Tarifa en Oferta Grua';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    CaptionML = ENU = 'General',
                                ESP = 'General';
                    field(ServRateNo; ServRateNo)
                    {
                        CaptionML = ENU = 'Service Rate',
                                    ESP = 'Tarifa de Servicio';

                        trigger OnLookup(var Text: Text): BoolEAN;
                        var
                            ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
                            ServiceItemRateList: Page "Service Item Rate List";
                        begin
                            ServiceItemRateHeader.RESET;
                            ServiceItemRateHeader.FILTERGROUP(2);
                            ServiceItemRateHeader.SETRANGE(Status, ServiceItemRateHeader.Status::Locked);
                            ServiceItemRateHeader.FILTERGROUP(0);
                            ServiceItemRateHeader.SETFILTER("Valid End Date", '%1..', WORKDATE);
                            CLEAR(ServiceItemRateList);
                            ServiceItemRateList.SETTABLEVIEW(ServiceItemRateHeader);
                            ServiceItemRateList.LOOKUPMODE(TRUE);
                            IF ServiceItemRateList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                ServiceItemRateList.GETRECORD(ServiceItemRateHeader);
                                ServRateNo := ServiceItemRateHeader.Code;
                            END;
                        end;
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

    trigger OnPostReport();
    var
        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
        LastLineNo: Integer;
    begin
        CLEAR(ServiceItemRateLineCrane);
        ServiceItemRateLineCrane.SETRANGE(Code, ServRateNo);
        IF ServiceItemRateLineCrane.FINDSET THEN BEGIN
            REPEAT
                CLEAR(CraneServQOpInvGLine);
                CraneServQOpInvGLine.SETRANGE("Quote No.", QuoteNo);
                CraneServQOpInvGLine.SETRANGE("Operation Line No.", QuoteOpLineNo);
                IF CraneServQOpInvGLine.FINDLAST THEN
                    LastLineNo := CraneServQOpInvGLine."Line No."
                ELSE
                    LastLineNo := 0;

                CLEAR(CraneServQOpInvGLine);
                CraneServQOpInvGLine."Quote No." := QuoteNo;
                CraneServQOpInvGLine."Operation Line No." := QuoteOpLineNo;
                CraneServQOpInvGLine."Line No." := LastLineNo + 10000;
                CraneServQOpInvGLine."Invoice Group No." := ServiceItemRateLineCrane."Invoice Group No.";
                CraneServQOpInvGLine."Vehicles Number" := 1;
                CraneServQOpInvGLine.INSERT(TRUE);

                CraneServQOpInvGLine.VALIDATE("Rate No.", ServRateNo);
                CraneServQOpInvGLine.MODIFY(TRUE);

            UNTIL ServiceItemRateLineCrane.NEXT = 0;
        END;

        MESSAGE(Text001, ServRateNo, QuoteNo);
    end;

    var
        ServRateNo: Code[20];
        QuoteNo: Code[20];
        QuoteOpLineNo: Integer;
        Text001: TextConst ENU = 'Service Rate No. %1 has been properly applied into Crane Service Quote No. %2', ESP = 'La Tarifa de Servicio Nº %1 ha sido correctamente volcada en la Oferta de Grúa Nº %2';

    procedure SetParams(pQuoteNo: Code[20]; pQuoteOpLineNo: Integer);
    begin
        QuoteNo := pQuoteNo;
        QuoteOpLineNo := pQuoteOpLineNo;
    end;
}

