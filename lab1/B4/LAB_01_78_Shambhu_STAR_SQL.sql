
CREATE TABLE LOCATION (
                Loaction_Id VARCHAR2(5) NOT NULL,
                Auction_Location VARCHAR2(25) NOT NULL,
                Country VARCHAR2(15) NOT NULL,
                Continent VARCHAR2(15) NOT NULL,
                Hemisphere VARCHAR2(10) NOT NULL,
                CONSTRAINT LOCATION_PK PRIMARY KEY (Loaction_Id)
);


CREATE TABLE Buyer (
                Buyer_Id VARCHAR2(6) NOT NULL,
                Buyer_Name VARCHAR2(25) NOT NULL,
                Buyer_Code VARCHAR2(10) NOT NULL,
                Buyer_Type VARCHAR2(5) NOT NULL,
                Buyer_Addr VARCHAR2(20) NOT NULL,
                Buyer_State VARCHAR2(15) NOT NULL,
                Buyer_Zip NUMBER(5) NOT NULL,
                CONSTRAINT BUYER_PK PRIMARY KEY (Buyer_Id)
);


CREATE TABLE CONSIGNER (
                Consigner_Id VARCHAR2(10) NOT NULL,
                Consigner_Name VARCHAR2(30) NOT NULL,
                Consigner_Code VARCHAR2(5) NOT NULL,
                Consigner_Type VARCHAR2(10) NOT NULL,
                Consigner_Addr VARCHAR2(30) NOT NULL,
                Consigner_State VARCHAR2(20) NOT NULL,
                Consigner_Zip NUMBER(6) NOT NULL,
                CONSTRAINT CONSIGNER_PK PRIMARY KEY (Consigner_Id)
);


CREATE TABLE Time (
                Time_Id VARCHAR2(5) NOT NULL,
                Year NUMBER(5) NOT NULL,
                Date_1 VARCHAR2(11) NOT NULL,
                Month NUMBER(2,12) NOT NULL,
                Quarter VARCHAR2(10) NOT NULL,
                CONSTRAINT TIME_PK PRIMARY KEY (Time_Id)
);


CREATE TABLE item (
                Item_Id VARCHAR2(10) NOT NULL,
                item_name VARCHAR2(15) NOT NULL,
                I_Dept VARCHAR2(15) NOT NULL,
                Item_Number NUMBER(10) NOT NULL,
                Sold_Flag NUMBER(2) NOT NULL,
                CONSTRAINT ITEM_PK PRIMARY KEY (Item_Id)
);


CREATE TABLE AUCTION_SALES (
                Auction_Id VARCHAR2(6) NOT NULL,
                Item_Id VARCHAR2(10) NOT NULL,
                Time_Id VARCHAR2(5) NOT NULL,
                Loaction_Id VARCHAR2(5) NOT NULL,
                Buyer_Id VARCHAR2(6) NOT NULL,
                Consigner_Id VARCHAR2(10) NOT NULL,
                Reserved_Price NUMBER(10) NOT NULL,
                Low_Estimate NUMBER(10) NOT NULL,
                High_Estimate NUMBER(10) NOT NULL,
                Sold_Price NUMBER(10) NOT NULL,
                CONSTRAINT AUCTION_SALES_PK PRIMARY KEY (Auction_Id, Item_Id, Time_Id, Loaction_Id, Buyer_Id, Consigner_Id)
);


ALTER TABLE AUCTION_SALES ADD CONSTRAINT LOCATION_AUCTION_SALES_FK
FOREIGN KEY (Loaction_Id)
REFERENCES LOCATION (Loaction_Id)
NOT DEFERRABLE;

ALTER TABLE AUCTION_SALES ADD CONSTRAINT BUYER_AUCTION_SALES_FK
FOREIGN KEY (Buyer_Id)
REFERENCES Buyer (Buyer_Id)
NOT DEFERRABLE;

ALTER TABLE AUCTION_SALES ADD CONSTRAINT CONSIGNER_AUCTION_SALES_FK
FOREIGN KEY (Consigner_Id)
REFERENCES CONSIGNER (Consigner_Id)
NOT DEFERRABLE;

ALTER TABLE AUCTION_SALES ADD CONSTRAINT TIME_AUCTION_SALES_FK
FOREIGN KEY (Time_Id)
REFERENCES Time (Time_Id)
NOT DEFERRABLE;

ALTER TABLE AUCTION_SALES ADD CONSTRAINT ITEM_AUCTION_SALES_FK
FOREIGN KEY (Item_Id)
REFERENCES item (Item_Id)
NOT DEFERRABLE;
