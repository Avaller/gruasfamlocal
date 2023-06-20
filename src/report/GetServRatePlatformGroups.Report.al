report 50039 "Get Serv Rate Platform Groups"
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
        PlatfServQInvGLine: Record "Platf. Serv. Q. Inv G Line_LDR";
        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
        LastLineNo: Integer;
    begin
        CLEAR(ServiceItemRateLinePlatf);
        ServiceItemRateLinePlatf.SETRANGE(Code, ServRateNo);
        IF ServiceItemRateLinePlatf.FINDSET THEN BEGIN
            REPEAT
                CLEAR(PlatfServQInvGLine);
                PlatfServQInvGLine.SETRANGE("Quote No.", QuoteNo);
                IF PlatfServQInvGLine.FINDLAST THEN
                    LastLineNo := PlatfServQInvGLine."Line No."
                ELSE
                    LastLineNo := 0;

                CLEAR(PlatfServQInvGLine);
                PlatfServQInvGLine."Quote No." := QuoteNo;
                PlatfServQInvGLine."Line No." := LastLineNo + 10000;
                PlatfServQInvGLine."Invoice Group No." := ServiceItemRateLinePlatf."Invoice Group No.";
                PlatfServQInvGLine.INSERT(TRUE);

                PlatfServQInvGLine.VALIDATE("Rate No.", ServRateNo);
                PlatfServQInvGLine.MODIFY(TRUE);

            UNTIL ServiceItemRateLinePlatf.NEXT = 0;
        END;

        MESSAGE(Text001, ServRateNo, QuoteNo);
    end;

    var
        ServRateNo: Code[20];
        QuoteNo: Code[20];
        QuoteOpLineNo: Integer;
        Text001: TextConst ENU = 'Service Rate No. %1 has been properly applied into Crane Service Quote No. %2', ESP = 'La Tarifa de Servicio Nº %1 ha sido correctamente volcada en la Oferta de Grúa Nº %2';

    procedure SetParams(pQuoteNo: Code[20]);
    begin
        QuoteNo := pQuoteNo;
    end;
}

