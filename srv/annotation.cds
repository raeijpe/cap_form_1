using {RegForm as Reg} from './admin-service';

annotate com.demo.cap.test with @fiori.draft.enabled;

annotate Reg.CategoryAssignment with @(
  UI:{
    LineItem: [      
      { Label: 'Category', Value: category_product}      
    ]
  }
);

@odata.draft.enabled
annotate Reg.Form with @(
  UI:{
    Common.semanticKey: 'ID',    
    SelectionFields: [company_name, contact_lastname],

    LineItem: [
      { Label: 'Company', Value: company_name},      
      { Label: 'Contact', Value: contact_firstname}
    ]
    ,
     HeaderInfo: {
			TypeName: 'Form',
			TypeNamePlural: 'Forms',
            Title: {Value: company_name}
		},
    Facets: [

        {
          ID: 'Collection1',
          $Type: 'UI.CollectionFacet',
          Label: 'Company',
          Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Company_data', Label: 'Data'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Company_address', Label: 'Address'},
          ]
        },
        {
          ID: 'Collection2',
          $Type: 'UI.CollectionFacet',
          Label: 'Contact',
          Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Contact_data', Label: 'Data'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Contact_address', Label: 'Address'}        
          ]
        },

        {$Type: 'UI.ReferenceFacet', Target: 'categories/@UI.LineItem', Label: '{i18n>childrens}'}
      ],
      FieldGroup#Company_data: {
        Data:[
            {$Type: 'UI.DataField', Value: company_name }
        ]
      },
      FieldGroup#Company_address: {
        Data:[
            {$Type: 'UI.DataField', Label: 'Street', Value: company_address_street },
            {$Type: 'UI.DataField', Label: 'House No', Value: company_address_houseNo },
            {$Type: 'UI.DataField', Label: 'Postal Code', Value: company_address_postalCode }
        ]
    },
    FieldGroup#Contact_data: {
        Data:[
            {$Type: 'UI.DataField', Label: 'Firstname', Value: contact_firstname },
            {$Type: 'UI.DataField', Label: 'Lastname', Value: contact_lastname }
            ]
        },
    FieldGroup#Contact_address: {
    Data:[
        {$Type: 'UI.DataField', Label: 'Street', Value: contact_address_street},
        {$Type: 'UI.DataField', Label: 'House No', Value: contact_address_houseNo},
        {$Type: 'UI.DataField', Label: 'Postal Code', Value: contact_address_postalCode}
    ]
    }
  }
) {
  ID @title:'ID' @odata.Type:'Edm.String'; 
  status @title:'Status' @odata.Type:'Edm.String'; 
  supplier_name @title:'Supplier' @odata.Type:'Edm.String' @mandatory;   
};

@odata.draft.enabled
annotate Reg.Category with @(
    UI:{
        Common.semanticKey: 'product',
        Identification: [{Value:product}],
        SelectionFields: [product, name],

        LineItem: [
          { Label: 'Product', Value: product},      
          { Label: 'Name', Value: name},
          { Label: 'Parent', Value: parent_product},
        ]
        ,
        HeaderInfo: {
                TypeName: 'Category',
                TypeNamePlural: 'Categories',
                Title: {Value: product},
                Description: {Value: name}
            },
        Facets: [

            {
            ID: 'Collection1',
            $Type: 'UI.CollectionFacet',
            Label: 'Data',
            Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Information', Label: 'Information'}
                ]
            },
            {$Type: 'UI.ReferenceFacet', Target: 'childrens/@UI.LineItem', Label: 'Childrens'}
        ],
        FieldGroup#Information: {
            Data:[
                {$Type: 'UI.DataField', Label: 'Product', Value: product},
                {$Type: 'UI.DataField', Label: 'Name', Value: name},
                {$Type: 'UI.DataField', Label: 'Description', Value: description},
                {$Type: 'UI.DataField', Label: 'Parent', Value: parent_product}
            ]        
        }
    }
)  {
    product @(
      title:'Product',
      odata.Type:'Edm.String',
      ValueList.entity:'Category',
      sap.hierarchy.node.for:'product'
      ); 
    name @title:'Name' @odata.Type:'Edm.String'; 
    parent @(
        title: 'Parent',
        ValueList.entity:'Category',
        sap.hierarchy.parent.node.for:'product',
        Common: {
            Text: parent.name
        }  
    );
    level @sap.hierarchy.level.for:'product';
    drilldown @sap.hierarchy.drill.state.for:'product';
};