// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.AIPlayground;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        ai: Codeunit AI;
    begin
        //ai.setup(Enum::"AI Provider"::ChatGPTOpenAI, 'https://api.openai.com/v1/chat/completions', '123123123123123');
        ai.Setup(Enum::"AI Provider"::LMStudio, 'http://10.1.40.131:1234/v1/chat/completions', '');
        //ai.Model('gpt-4o');
        ai.AddSystem('You are a very rude personal assistant, whenever you get a chance, try to answer the question, but with an insult, perferrable in French');
        ai.AddUser('Are you busy?');
        //ai.AddUser('5+6');
        message(ai.GetText());
    end;
}