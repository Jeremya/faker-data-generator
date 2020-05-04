//run with node: node operations_generator.js
var faker = require('faker');
var fs = require('fs');
var spacer = ";"
var fileName = 'operations';

// Setup variables
var numberOfOperations = 1000;
var numberOfOperationsOnExistingIban = 100000;

var operationsFinal = [];
var operationsStart = [];

generateCsvWithFakeData(fileName);

function generateCsvWithFakeData(fileName) {
    
    var tableFileName = fileName + ".csv"
    var tableFile = fs.createWriteStream(tableFileName, {
        flags: 'a'
    })
    
    for (j = 0; j < numberOfOperations; j ++) {
        var operation = {};
        operation.iban = faker.finance.iban("FR");
        operation.account_code = "A" + faker.finance.account();
        operationsStart.push(operation);
        generateOperation(operation);

        operationsFinal.push(operation);
    }   

    // add operations on existing iban
    for (k = 0; k < numberOfOperationsOnExistingIban; k ++) {
        var operation = {};
        generateOperation(operation);
        var index = Math.floor(Math.random() * operationsStart.length);
        operation.iban = operationsStart[index].iban;
        operation.account_code = operationsStart[index].account_code;
        operationsFinal.push(operation);
    }

    var keys = Object.keys(operationsFinal[0]);
    var operation_csv = jsonArrayToCsv(keys);
    console.log(operation_csv);
    tableFile.write(operation_csv);
}

function generateOperation(operation) {
        operation.operation_id = faker.random.uuid();
        operation.label = faker.lorem.words(4);
        operation.date_operation = faker.date.past().toISOString(); // timestamp
        operation.date_validation = faker.date.past().toISOString(); // timestamp
        operation.date_correction = faker.date.past().toISOString(); // timestamp
        operation.amount = faker.finance.amount(0.10,10000.00,2);
        operation.original_operation_id = ''; //original_operation_id
}

function jsonArrayToCsv(keys) {
    var csv = "";
    // write header
    csv += keys.join(';') + '\n';

    for(var line of operationsFinal) {
        csv += keys.map(key => line[key]).join(spacer) + '\n';
    }
    return csv;
}

