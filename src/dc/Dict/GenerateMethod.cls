Class dc.Dict.GenerateMethod Extends %RegisteredObject
{

ClassMethod Run(className, method, formalSpec, mensage) [ Language = objectscript ]
{
    set classMethod = ##class(%Dictionary.MethodDefinition).%OpenId(className_"||"_method)
    set:(classMethod = "") classMethod = ##class(%Dictionary.MethodDefinition).%New(className_":"_method)

    Set mensage = mensage_",consider using the ["_formalSpec_"] variables, already have assigned values. "
    Set mensage = mensage_", does not define the value of ["_formalSpec_"] variables. "

    set implementation = ##class(dc.GPT.Engine).generate(mensage,"implementation")

    set classMethod.Description = "Gerenate by GPT.Engine :"_mensage
    Do classMethod.Implementation.Write(implementation)
    set classMethod.FormalSpec = formalSpec
    set classMethod.ClassMethod = 1
    set classMethod.Language = "python"
    do classMethod.%Save()
}

ClassMethod teste1()
{
    Set className="dc.Dict.GenerateMethod"
    Set method="teste"
    Set formalSpec="p1,p2"
    Set mensage="print p1 and p2 values, if p1 is equals 42 print life"
    Do ##class(dc.Dict.GenerateMethod).Run(className, method, formalSpec, mensage)
}

}
