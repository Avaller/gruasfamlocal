report 50026 "Forfait Crane Quote"
{
    // version FAM

    RDLCLayout = './Forfait Crane Quote.rdlc';
    CaptionML = ENU = 'Crane Quote',
                ESP = 'Oferta de Grúas';
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
            column(QuoteDate_CraneServiceQuoteHeader; FORMAT("Crane Service Quote Header"."Quote Date"))
            {
            }
            column(TotalAmount_CraneServiceQuoteHeader; TotalAmount)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(PaymentMethod_Description; PaymentMethod.Description)
            {
            }
            column(FullCommentText_CraneServiceQuoteHeader; FullCommentText)
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
                DataItemLink = Code = FIELD(Quote no.);
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
                column(ForfaitAmount_CraneServQuoteOpLine;"Crane Service Quote Op. Line"."Forfait Amount")
                {
                }
                dataitem(DataItem1000000002;Table50024)
                {
                    DataItemLink = Quote No.=FIELD(Quote No.),
                                   Operation Line No.=FIELD(Line No.);
                    DataItemLinkReference = "Crane Service Quote Op. Line";
                }
                dataitem(DataItem1000000003;Table50025)
                {
                    DataItemLink = Quote No.=FIELD(Quote No.),
                                   Operation Line No.=FIELD(Line No.);
                    DataItemLinkReference = "Crane Service Quote Op. Line";
                    column(InvoiceGroupDescription_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Invoice Group Description")
                    {
                    }
                    column(VehiclesNumber_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Vehicles Number")
                    {
                    }
                    column(MaxHours_CraneServQOpInvGLine;"Crane Serv. Q. Op. Inv. G Line"."Maximum Hours")
                    {
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
                    end;
                }
            }

            trigger OnAfterGetRecord();
            var
                ShiptoAddress : Record "222";
                Cust : Record "18";
                CraneServiceQuoteOpLine : Record "50022";
            begin
                Cust.GET("Customer No.");

                IF "Ship-to Address Code" <> '' THEN BEGIN
                  ShiptoAddress.GET("Customer No.","Ship-to Address Code");
                  ShipToAddr[1] := ShiptoAddress.Name;
                  ShipToAddr[2] := ShiptoAddress.Contact;
                  ShipToAddr[3] := ShiptoAddress.Address;
                  ShipToAddr[4] := ShiptoAddress."Post Code";
                  ShipToAddr[5] := ShiptoAddress.City;
                  ShipToAddr[6] := ShiptoAddress.County;
                END ELSE BEGIN

                  ShipToAddr[1] := Cust.Name;
                  ShipToAddr[2] := Cust.Contact;
                  ShipToAddr[3] := Cust.Address;
                  ShipToAddr[4] := Cust."Post Code";
                  ShipToAddr[5] := Cust.City;
                  ShipToAddr[6] := Cust.County;
                END;

                CLEAR(CraneServiceQuoteOpLine);
                CraneServiceQuoteOpLine.SETRANGE("Quote No.","Crane Service Quote Header"."Quote no.");
                IF CraneServiceQuoteOpLine.FINDSET THEN BEGIN
                  REPEAT
                    CraneServiceQuoteOpLine.CALCFIELDS("Forfait Amount");
                    TotalAmount += CraneServiceQuoteOpLine."Forfait Amount";
                  UNTIL CraneServiceQuoteOpLine.NEXT = 0;
                END;

                PaymentMethod.GET(Cust."Payment Method Code");
                PaymentTerms.GET(Cust."Payment Terms Code");

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
        CraneMgtSetup : Record "50028";
        TotalAmount : Decimal;
        PaymentTerms : Record "3";
        PaymentMethod : Record "289";
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

