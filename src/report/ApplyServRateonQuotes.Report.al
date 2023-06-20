report 50044 "Apply Serv. Rate on Quotes"
{
    // version FAM

    CaptionML = ENU = 'Apply Serv. Rate on Quotes',
                ESP = 'Aplicar Tarifa en Oferta';
    ProcessingOnly = true;

    /*
    dataset
    {
        dataitem(DataItem1000000000; 50020)
        {

            trigger OnAfterGetRecord();
            begin
                "Crane Service Quote Header".TESTFIELD("Quote Status", "Crane Service Quote Header"."Quote Status"::Open);

                "Crane Service Quote Header"."Rate Code" := SelectedRate;
                "Crane Service Quote Header".MODIFY(TRUE);

                IF "Crane Service Quote Header"."Platform Quote" THEN BEGIN
                    CLEAR(PlatfServQInvGLine);
                    PlatfServQInvGLine.SETRANGE("Quote No.", "Crane Service Quote Header"."Quote no.");
                    IF PlatfServQInvGLine.FINDSET THEN BEGIN
                        REPEAT
                            PlatfServQInvGLine.VALIDATE("Rate No.", SelectedRate);
                            PlatfServQInvGLine.MODIFY(TRUE);
                        UNTIL PlatfServQInvGLine.NEXT = 0;
                    END;
                END ELSE BEGIN
                    CLEAR(CraneServQOpInvGLine);
                    CraneServQOpInvGLine.SETRANGE("Quote No.", "Crane Service Quote Header"."Quote no.");
                    IF CraneServQOpInvGLine.FINDSET THEN BEGIN
                        REPEAT
                            CraneServQOpInvGLine."Rate No." := SelectedRate;
                            CraneServQOpInvGLine.MODIFY(TRUE);
                        UNTIL CraneServQOpInvGLine.NEXT = 0;
                    END;
                END;
            end;
        }
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
                    field(SelectedRate; SelectedRate)
                    {
                        CaptionML = ENU = 'Selected Rate No.',
                                    ESP = 'Cód. Tarifa Seleccionada';
                        TableRelation = "Service Item Rate Header".Code WHERE(Status = CONST(Locked));
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
    begin
        MESSAGE(txtEnd, SelectedRate);
    end;

    var
        CraneServQOpInvGLine: Record "50025";
        SelectedRate: Code[20];
        txtEnd: TextConst ENU = 'Serv. Rate No. %1 has been applied', ESP = 'Tarifa Nº. %1 aplicada correctamente.';
        PlatfServQInvGLine: Record "50054";
    
    */
}

