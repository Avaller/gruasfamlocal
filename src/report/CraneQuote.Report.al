report 50013 "Crane Quote"
{
    // version FAM

    RDLCLayout = './Crane Quote.rdlc';
    CaptionML = ENU = 'Special Operations Crane Quote',
                ESP = 'Oferta de Grúas Op. Especiales';
    DefaultLayout = Word;

    /*
    dataset
    {
        dataitem(DataItem1000000000; 50020)
        {
            DataItemTableView = SORTING(Quote no.)
                                ORDER(Ascending);
            RequestFilterFields = "Quote no.";
            column(Logo_CompanyInformation; CompanyInformation.Logo)
            {
            }
            column(QuoteNo_CraneServiceQuoteHeader; "Crane Service Quote Header"."Quote no.")
            {
            }
            column(StartingDate_CraneServiceQuoteHeader; FORMAT("Crane Service Quote Header"."Starting Date"))
            {
            }
            column(EndingDate_CraneServiceQuoteHeader; FORMAT("Crane Service Quote Header"."Ending Date"))
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(ShipToAddr1_CraneServiceQuoteHeader; ShipToAddr[1])
            {
            }
            column(ShipToAddr2_CraneServiceQuoteHeader; ShipToAddr[2])
            {
            }
            column(ShipToAddr3_CraneServiceQuoteHeader; ShipToAddr[3])
            {
            }
            column(ShipToAddr4_CraneServiceQuoteHeader; ShipToAddr[4])
            {
            }
            column(ShipToAddr5_CraneServiceQuoteHeader; ShipToAddr[5])
            {
            }
            column(ShipToAddr6_CraneServiceQuoteHeader; ShipToAddr[6])
            {
            }
            column(Description_CraneServiceQuoteHeader; "Crane Service Quote Header".Description)
            {
            }
            column(Description2_CraneServiceQuoteHeader; "Crane Service Quote Header"."Description 2")
            {
            }
            column(FullComments_CraneServiceQuoteHeader; FullCommentText)
            {
            }
            column(QuoteDate_CraneServiceQuoteHeader; FORMAT("Crane Service Quote Header"."Quote Date"))
            {
            }
            column(Desc_PayMethod; PaymentMethod.Description)
            {
            }
            column(Desc_PayTerms; PaymentTerms.Description)
            {
            }
            dataitem(DataItem1000000004; Table13)
            {
                DataItemLink = Code = FIELD(Salesperson Code);
                column(Name_SalesPerson_Purchaser; "Salesperson/Purchaser".Name)
                {
                }
            }
            dataitem(DataItem1000000005; Table50015)
            {
                DataItemLink = Code = FIELD(Rate Code);
                column(ResLine_GroupNo; "Service Item Rate Line - Res."."Resource Group No.")
                {
                }
                column(ResLine_GroupDescription; "Service Item Rate Line - Res."."Resource Group Description")
                {
                }
                column(ResLine_MinHours; "Service Item Rate Line - Res."."Min Hours")
                {
                }
                column(ResLine_HourPrice; "Service Item Rate Line - Res."."Price Hour")
                {
                }
            }
            dataitem(DataItem1000000001; Table50022)
            {
                DataItemLink = Quote Type=FIELD(Quote Type),
                               Quote No.=FIELD(Quote no.);
                DataItemTableView = SORTING(Quote No.,Line No.)
                                    ORDER(Ascending);
                column(OpNo_CraneServQuoteOpLine;"Crane Service Quote Op. Line"."Operation No.")
                {
                }
                column(Description_CraneServQuoteOpLine;"Crane Service Quote Op. Line"."Operation Description")
                {
                }
                dataitem(DataItem1000000002;Table50024)
                {
                    DataItemLink = Quote No.=FIELD(Quote No.),
                                   Operation Line No.=FIELD(Line No.);
                    DataItemLinkReference = "Crane Service Quote Op. Line";
                    column(ConceptCode_CraneServQOpMiscLine;"Crane Serv. Q. Op. Mic S. Line"."Concept Code")
                    {
                    }
                    column(Description_CraneServQOpMiscLine;"Crane Serv. Q. Op. Mic S. Line".Description)
                    {
                    }
                    column(Quantity_CraneServQOpMiscLine;"Crane Serv. Q. Op. Mic S. Line".Quantity)
                    {
                    }
                    column(UnitPrice_CraneServQOpMiscLine;"Crane Serv. Q. Op. Mic S. Line"."Unit Price")
                    {
                    }
                }
                dataitem(DataItem1000000003;Table50025)
                {
                    DataItemLink = Quote No.=FIELD(Quote No.),
                                   Operation Line No.=FIELD(Line No.);
                    DataItemLinkReference = "Crane Service Quote Op. Line";
                    DataItemTableView = SORTING(Print Order)
                                        ORDER(Ascending);
                    column(InvoiceGroupDescription_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Invoice Group Description")
                    {
                    }
                    column(VehiclesNumber_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Vehicles Number")
                    {
                    }
                    column(MinTreatmentType_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Minimum Treatment Type")
                    {
                    }
                    column(MinLabourHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Minimum Laboral Hours")
                    {
                    }
                    column(MinSaturdayHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Minimum Saturday Hours")
                    {
                    }
                    column(MinHolidayHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Minimum Holiday Hours")
                    {
                    }
                    column(MinNightHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Minimum Night Hours")
                    {
                    }
                    column(MaxHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Maximum Hours")
                    {
                    }
                    column(InvDispl_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Invoice Displacement")
                    {
                    }
                    column(KMFranch_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."KM Franchise")
                    {
                    }
                    column(KMTime_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."KM-Time Qty.")
                    {
                    }
                    column(DispAmount_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Displacement Amount")
                    {
                    }
                    column(InvExitFee_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Invoice Exit Fee")
                    {
                    }
                    column(DispDescrption_CraneServQOpInvGLine;DisplacementDescription)
                    {
                    }
                    dataitem(DataItem1000000006;Table50016)
                    {
                        DataItemLink = Invoice Group No.=FIELD(Invoice Group No.),
                                       Code=FIELD(Rate No.);
                        column(HourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Hour Price")
                        {
                        }
                        column(NightHourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Night Hour Price")
                        {
                        }
                        column(SaturdayHourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Saturday Hour Price")
                        {
                        }
                        column(SaturdayNigthHourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Night Hour Price")
                        {
                        }
                        column(HolidayHourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Holiday Hour Price")
                        {
                        }
                        column(HolidayNigthHourPrice_ServiceItemRateLineCrane;"Service Item Rate Line - Crane"."Night Hour Price")
                        {
                        }
                        column(KMPrice_ServiceItemRateLineCrane;DisplacementKMPrice)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF "Crane Serv. Q. Op. Inv. G Line"."Invoice Displacement" THEN BEGIN
                              IF ((NOT "Crane Serv. Q. Op. Inv. G Line"."Apply standard KM") AND ("Crane Serv. Q. Op. Inv. G Line"."Displacement Amount" <> 0)) OR
                                 ("Crane Serv. Q. Op. Inv. G Line"."Displacement Type" = "Crane Serv. Q. Op. Inv. G Line"."Displacement Type"::Hours) THEN BEGIN
                                DisplacementKMPrice := '';
                              END ELSE BEGIN
                                DisplacementKMPrice := FORMAT("Service Item Rate Line - Crane"."KM Price",0,'<Precision,2:2><sign><Integer Thousand><Decimals>');
                              END;
                            END;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        Branch : Record "50203";
                        ServiceOrderMgt : Codeunit "50004";
                        ShiptoAddress : Record "222";
                        Customer : Record "18";
                        DisplacementQty : Integer;
                        ToCP : Code[20];
                        ToCity : Text[30];
                        LF : Char;
                        CR : Char;
                        CRLF : Text[2];
                    begin
                        DisplacementDescription := '';
                        DisplacementKMPrice := '';
                        IF "Crane Serv. Q. Op. Inv. G Line"."Invoice Displacement" THEN BEGIN
                          IF (NOT "Crane Serv. Q. Op. Inv. G Line"."Apply standard KM") AND ("Crane Serv. Q. Op. Inv. G Line"."Displacement Amount" <> 0) THEN BEGIN
                            //=== RQ19.29.395 - LBARQUIN - 28.12.2020 ===
                            DisplacementDescription := STRSUBSTNO(Text001,FORMAT("Crane Serv. Q. Op. Inv. G Line"."Displacement Amount",0,'<Precision,2><sign><Integer Thousand><Decimals,3>'));
                          END ELSE BEGIN

                            IF ("Crane Serv. Q. Op. Inv. G Line"."KM Franchise" <> 0) THEN
                              DisplacementDescription := STRSUBSTNO(Text002,"Crane Serv. Q. Op. Inv. G Line"."KM Franchise");

                            IF ("Crane Serv. Q. Op. Inv. G Line"."Displacement Type" = "Crane Serv. Q. Op. Inv. G Line"."Displacement Type"::Hours) THEN
                              DisplacementDescription := Text003;
                          END;
                        //  ELSE IF (NOT "Crane Serv. Q. Op. Inv. G Line"."Apply standard KM") THEN BEGIN
                        //
                        //   //Obtenemos el origen, que es la info de la sucursal configurada en Crane Mgt Setup
                        //   Branch.GET(CraneMgtSetup."Internal Branch");
                        //   Branch.TESTFIELD("Post Code");
                        //   Branch.TESTFIELD(City);
                        //
                        //   //El destino depende de la direccion
                        //    IF "Crane Service Quote Header"."Ship-to Address Code" <> '' THEN BEGIN
                        //      ShiptoAddress.GET("Crane Service Quote Header"."Customer No.","Crane Service Quote Header"."Ship-to Address Code");
                        //      ToCP := ShiptoAddress."Post Code";
                        //      ToCity := ShiptoAddress.City;
                        //    END ELSE BEGIN
                        //      Customer.GET("Crane Service Quote Header"."Customer No.");
                        //      ToCP := Customer."Post Code";
                        //      ToCity := Customer.City;
                        //    END;
                        //
                        //    DisplacementQty := ServiceOrderMgt.GetDistanceDuration(Branch."Post Code",Branch.City,ToCP,ToCity,"Crane Serv. Q. Op. Inv. G Line",FALSE);
                        //
                        //    IF "Crane Serv. Q. Op. Inv. G Line"."Displacement Type" = "Crane Serv. Q. Op. Inv. G Line"."Displacement Type"::KMs THEN
                        //      DisplacementDescription := STRSUBSTNO('%1 - %2 %3 %4',Branch.City,ToCity,DisplacementQty,'Km') + ' \\ ' + STRSUBSTNO('%2 - %1 %3 %4',Branch.City,ToCity,DisplacementQty,'Km')
                        //    ELSE
                        //      DisplacementDescription := STRSUBSTNO('%1 - %2 %3 %4',Branch.City,ToCity,DisplacementQty,'Horas') + ' \\ ' + STRSUBSTNO('%2 - %1 %3 %4',Branch.City,ToCity,DisplacementQty,'Horas')
                        END;
                    end;
                }
            }

            trigger OnAfterGetRecord();
            var
                ShiptoAddress : Record "222";
                Cust : Record "18";
            begin
                IF "Ship-to Address Code" <> '' THEN BEGIN
                  ShiptoAddress.GET("Customer No.","Ship-to Address Code");
                  ShipToAddr[1] := ShiptoAddress.Name;
                  ShipToAddr[2] := "Crane Service Quote Header"."Contact Name";
                  ShipToAddr[3] := ShiptoAddress.Address;
                  ShipToAddr[4] := ShiptoAddress."Post Code";
                  ShipToAddr[5] := ShiptoAddress.City;
                  ShipToAddr[6] := ShiptoAddress.County;
                END ELSE BEGIN
                  Cust.GET("Customer No.");
                  ShipToAddr[1] := Cust.Name;
                  ShipToAddr[2] := "Crane Service Quote Header"."Contact Name";
                  ShipToAddr[3] := Cust.Address;
                  ShipToAddr[4] := Cust."Post Code";
                  ShipToAddr[5] := Cust.City;
                  ShipToAddr[6] := Cust.County;
                END;

                Customer.GET("Customer No.");
                IF PaymentMethod.GET(Customer."Payment Method Code") THEN;

                IF PaymentTerms.GET(Customer."Payment Terms Code") THEN;
                FullCommentText := GetQuoteComments("Crane Service Quote Header"."Quote no.");
            end;

            trigger OnPreDataItem();
            begin
                CompanyInformation.GET();
                CompanyAddress[1] := CompanyInformation.Address;
                CompanyAddress[2] := CompanyInformation."Phone No.";
                CompanyAddress[3] := CompanyInformation."Fax No.";
                CompanyAddress[4] := CompanyInformation."Post Code";
                CompanyAddress[5] := CompanyInformation.City+' ('+CompanyInformation.County+')';
                CompanyAddress[6] := CompanyInformation."Home Page";
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CraneMgtSetup.GET;
    end;

    var
        ShipToAddr : array [8] of Text;
        CompanyInformation : Record "79";
        CompanyAddress : array [8] of Text;
        DisplacementDescription : Text;
        DisplacementKMPrice : Text;
        CraneMgtSetup : Record "50028";
        Text001 : TextConst ENU='Fixed amount: %1 eur.',ESP='Importe fijo: %1 eur.';
        Text002 : TextConst ENU='Franchise of %1 Kms will be applied.',ESP='Se aplicará una franquicia de %1 Kms.';
        Text003 : TextConst ENU='The displacement will be invoiced for hours.',ESP='El desplazamiento se facturará por horas.';
        Customer : Record "18";
        PaymentMethod : Record "289";
        PaymentTerms : Record "3";
        FullCommentText : Text;

    local procedure GetQuoteComments(pQuoteNo : Code[20]) : Text;
    var
        ServiceCommentLine : Record "5906";
        tempText : Text;
    begin
        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name",ServiceCommentLine."Table Name"::"Crane Quote");
        ServiceCommentLine.SETRANGE("Table Subtype",ServiceCommentLine."Table Subtype"::"0");
        ServiceCommentLine.SETRANGE("No.",pQuoteNo);
        ServiceCommentLine.SETRANGE(Type,ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.",0);
        IF ServiceCommentLine.FINDSET THEN BEGIN
          REPEAT
            tempText := tempText + ' '+ ServiceCommentLine.Comment;
          UNTIL ServiceCommentLine.NEXT = 0;
        END;

        EXIT(tempText);
    end;
    */
}

