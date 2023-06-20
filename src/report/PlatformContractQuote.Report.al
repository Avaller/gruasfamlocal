report 50015 "Platform Contract Quote"
{
    // version FAM

    RDLCLayout = './Platform Contract Quote.rdlc';
    CaptionML = ENU = 'Platform Contract Quote',
                ESP = 'Oferta de Plataformas';
    DefaultLayout = Word;

    /*
    dataset
    {
        dataitem(DataItem1000000000; 50020)
        {
            DataItemTableView = WHERE(Platform Quote=CONST(Yes));
            RequestFilterFields = "Quote no.";
            column(CompanyAddr1; CompanyAddress[1])
            {
            }
            column(CompanyAddr2; CompanyAddress[2])
            {
            }
            column(CompanyAddr3; CompanyAddress[3])
            {
            }
            column(CompanyAddr4; CompanyAddress[4])
            {
            }
            column(CompanyAddr5; CompanyAddress[5])
            {
            }
            column(CompanyAddr6; CompanyAddress[6])
            {
            }
            column(CompanyAddr7; CompanyAddress[7])
            {
            }
            column(CompanyAddr8; CompanyAddress[8])
            {
            }
            column(WORKDATE; FORMAT(WORKDATE, 0, 1))
            {
            }
            column(WORKDATE_CM; FORMAT(CALCDATE('<1M+CM>', WORKDATE), 0, 1))
            {
            }
            column(QuoteNo_PlatfQuote; "Crane Service Quote Header"."Quote no.")
            {
            }
            column(Description_PlatfQuote; "Crane Service Quote Header".Description)
            {
            }
            column(Description2_PlatfQuote; "Crane Service Quote Header"."Description 2")
            {
            }
            column(FullComments_PlatfQuote; FullCommentText)
            {
            }
            column(Desc_PayMethod; PaymentMethod.Description)
            {
            }
            column(Desc_PayTerms; PaymentTerms.Description)
            {
            }
            column(ShipToAddr1_PlatfQuote; CustAddress[1])
            {
            }
            column(ShipToAddr2_PlatfQuote; CustAddress[2])
            {
            }
            column(ShipToAddr3_PlatfQuote; CustAddress[3])
            {
            }
            column(ShipToAddr4_PlatfQuote; CustAddress[4])
            {
            }
            column(ShipToAddr5_PlatfQuote; CustAddress[5])
            {
            }
            column(ShipToAddr6_PlatfQuote; CustAddress[6])
            {
            }
            column(ResponsibilityCenter_PlatfQuote; "Crane Service Quote Header"."Responsability Center")
            {
            }
            dataitem(DataItem1000000001; Table50054)
            {
                DataItemLink = Quote No.=FIELD(Quote no.);
                column(ServiceitemModel_PlatfQuoteLine; "Platf. Serv. Q. Inv. G Line"."Invoice Group Description")
                {
                }
                column(MonthAmount_PlatfQuoteLine; "Platf. Serv. Q. Inv. G Line"."Mouth Cost")
                {
                }
                column(DayAmount_PlatfQuoteLine; "Platf. Serv. Q. Inv. G Line"."Day Cost")
                {
                }
                column(Deliver_Pickup_Price_PlatfQuoteLine; "Platf. Serv. Q. Inv. G Line"."Deliver/Pickup Price")
                {
                }
                column(ServItemInvGroup_Branch; ServItemInvGroup.Branch)
                {
                }
                column(ServItemInvGroup_Model; ServItemInvGroup.Model)
                {
                }
                column(ServItemInvGroup_Height; ServItemInvGroup.Height)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF ServItemInvGroup.GET("Platf. Serv. Q. Inv. G Line"."Invoice Group No.") THEN;

                    "Platf. Serv. Q. Inv. G Line".CALCFIELDS("Invoice Group Description");
                end;
            }

            trigger OnAfterGetRecord();
            var
                ShiptoAddress: Record "222";
            begin
                Customer.GET("Customer No.");
                IF PaymentMethod.GET(Customer."Payment Method Code") THEN;

                IF PaymentTerms.GET(Customer."Payment Terms Code") THEN;
                IF "Crane Service Quote Header"."Ship-to Address Code" <> '' THEN BEGIN
                    ShiptoAddress.GET(Customer."No.", "Crane Service Quote Header"."Ship-to Address Code");
                    CustAddress[1] := ShiptoAddress.Name;
                    CustAddress[2] := ShiptoAddress.Contact;
                    CustAddress[3] := ShiptoAddress.Address + ShiptoAddress."Address 2";
                    CustAddress[4] := ShiptoAddress."Post Code";
                    CustAddress[5] := ShiptoAddress.City;
                    CustAddress[6] := ShiptoAddress.County;
                END ELSE BEGIN
                    CustAddress[1] := Customer.Name;
                    CustAddress[2] := Customer.Contact;
                    CustAddress[3] := Customer.Address + Customer."Address 2";
                    CustAddress[4] := Customer."Post Code";
                    CustAddress[5] := Customer.City;
                    CustAddress[6] := Customer.County;
                END;
                FullCommentText := GetQuoteComments("Crane Service Quote Header"."Quote no.");
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
        CompanyInfo.GET();
        //CompanyAddress[1] := CompanyInfo.Name;
        CompanyAddress[1] := CompanyInfo.Address + CompanyInfo."Address 2";
        CompanyAddress[2] := CompanyInfo."Phone No.";
        CompanyAddress[3] := CompanyInfo."Fax No.";
        CompanyAddress[4] := CompanyInfo."Post Code";
        CompanyAddress[5] := CompanyInfo.City;
        CompanyAddress[6] := CompanyInfo."Home Page";
        CompanyAddress[7] := CompanyInfo.County;
    end;

    var
        CompanyInfo: Record "79";
        CompanyAddress: array[8] of Text;
        Customer: Record "18";
        PaymentMethod: Record "289";
        ServiceItem: Record "5940";
        PaymentTerms: Record "3";
        CustAddress: array[8] of Text;
        ServItemInvGroup: Record "50005";
        FullCommentText: Text;

    local procedure GetQuoteComments(pQuoteNo: Code[20]): Text;
    var
        ServiceCommentLine: Record "5906";
        tempText: Text;
    begin
        CLEAR(ServiceCommentLine);
        ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Crane Quote");
        ServiceCommentLine.SETRANGE("Table Subtype", ServiceCommentLine."Table Subtype"::"0");
        ServiceCommentLine.SETRANGE("No.", pQuoteNo);
        ServiceCommentLine.SETRANGE(Type, ServiceCommentLine.Type::General);
        ServiceCommentLine.SETRANGE("Table Line No.", 0);
        IF ServiceCommentLine.FINDSET THEN BEGIN
            REPEAT
                tempText := tempText + ' ' + ServiceCommentLine.Comment;
            UNTIL ServiceCommentLine.NEXT = 0;
        END;

        EXIT(tempText);
    end;
    */
}

