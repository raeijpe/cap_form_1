namespace com.demo.cap.test;

using { Currency, managed, cuid, sap.common.CodeList } from '@sap/cds/common';

entity Form: managed {
    key ID: UUID;
    status: String enum { Draft; Created; Saved; Awaiting; Cancelled; Approved; Rejected; Outdated};
    company: Company;
    contact: ContactPerson;
    categories: Composition of many CategoryAssignment on categories.form = $self;
}

type Company{
    name: String(50);
    address: Address; 
}

type ContactPerson {
    firstname: String(30);
    lastname: String(30); 
    address: Address;       
}

type Address {
    street: String(30);
    houseNo: String(5);
    postalCode: String(6);
    city: String(50);    
    country: String(50);    
}

@cds.odata.valuelist 
entity Category: managed {
    key product: String(10);
    name: String(50);
    description: String(200);
    parent: Association to Category;
    level:Integer;
    drilldown:String(16);
    childrens: Composition of many Category on childrens.parent = $self;
}

entity CategoryAssignment: managed {
    key ID: UUID;
    form: Association to Form;
    category: Association to Category;
}