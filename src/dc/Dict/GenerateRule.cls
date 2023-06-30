Class dc.Dict.GenerateRule Extends %RegisteredObject [ Language = python ]
{

ClassMethod Run(className, mensage) [ Language = objectscript ]
{
    set classRuleDefinition = ##class(%Dictionary.XDataDefinition).%OpenId(className_"||RuleDefinition")
    set:(classRuleDefinition = "") classRuleDefinition = ##class(%Dictionary.XDataDefinition).%New(className_":RuleDefinition")

    set implementation = ##class(dc.GPT.Engine).generate(mensage,"rule")
    
    Do classRuleDefinition.Data.Write(implementation)

    set classRuleDefinition.Deprecated = ""
    set classRuleDefinition.Description = "Gerenate by GPT.Engine :"_mensage
    set classRuleDefinition.Internal = "0"
    set classRuleDefinition.MimeType = "text/xml"
    set classRuleDefinition.Name = "RuleDefinition"
    set classRuleDefinition.SchemaSpec = ""
    set classRuleDefinition.SequenceNumber = "2"
    set classRuleDefinition.XMLNamespace = "http://www.intersystems.com/rule"

    do classRuleDefinition.%Save()
    return implementation
}

}
