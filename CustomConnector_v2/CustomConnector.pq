// This file contains your Data Connector logic
[Version = "1.0.0"]
section CustomConnector;

[DataSource.Kind="CustomConnector", Publish="CustomConnector.Publish"]
shared CustomConnector.Contents = (apiUrl as text, optional keyFieldName as text, optional keyFieldValue as text) =>
   let
        requestBody = "{"""&keyFieldName&""":"""&keyFieldValue&"""}",
        apiResponse = Web.Contents(apiUrl, [Content = Text.ToBinary(requestBody)]),
        json = Json.Document(apiResponse),
        table2 = Record.ToTable(json),
        table = Table.FromRecords(json)
    in
        table2;

// Data Source Kind description
CustomConnector = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Anonymous = []
    ]
];

// Data Source UI publishing description
CustomConnector.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = CustomConnector.Icons,
    SourceTypeImage = CustomConnector.Icons
];

CustomConnector.Icons = [
    Icon16 = { Extension.Contents("CustomConnector16.png"), Extension.Contents("CustomConnector20.png"), Extension.Contents("CustomConnector24.png"), Extension.Contents("CustomConnector32.png") },
    Icon32 = { Extension.Contents("CustomConnector32.png"), Extension.Contents("CustomConnector40.png"), Extension.Contents("CustomConnector48.png"), Extension.Contents("CustomConnector64.png") }
];
