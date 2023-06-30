Class dc.Dict.GenerateMethod Extends %RegisteredObject
{

ClassMethod Run(className, method, formalSpec, mensage) [ Language = objectscript ]
{
    set classMethod = ##class(%Dictionary.MethodDefinition).%OpenId(className_"||"_method)
    set:(classMethod = "") classMethod = ##class(%Dictionary.MethodDefinition).%New(className_":"_method)

    If (formalSpec '= "") {
        Set mensage = mensage_",consider using the ["_formalSpec_"] variables, already have assigned values. "
        Set mensage = mensage_", does not define the value of ["_formalSpec_"] variables. "
    }

    set implementation = ##class(dc.GPT.Engine).generate(mensage,"implementation")

    set classMethod.Description = "Gerenate by GPT.Engine :"_mensage
    Do classMethod.Implementation.Write(implementation)
    set classMethod.FormalSpec = formalSpec
    set classMethod.ClassMethod = 1
    set classMethod.Language = "python"
    do classMethod.%Save()
}

ClassMethod FixBug(className, method, mensage) [ Language = objectscript ]
{
    set classMethod = ##class(%Dictionary.MethodDefinition).%OpenId(className_"||"_method)
    Quit:(classMethod = "")

    Set formalSpec = classMethod.FormalSpec
    Set implementationOld = classMethod.Implementation.Read()

    Set mensage = "this code has a defect rewrite:"_mensage_$c(13,10)
    Set mensage = mensage_implementationOld_$c(13,10)
    Set mensage = mensage_"consider using the ["_formalSpec_"] variables, already have assigned values. "_$c(13,10)
    Set mensage = mensage_", does not define the value of ["_formalSpec_"] variables. "

    Set implementation = ##class(dc.GPT.Engine).generate(mensage,"implementation")

    Do classMethod.Implementation.Write(implementation)
    set classMethod.FormalSpec = formalSpec
    set classMethod.ClassMethod = 1
    set classMethod.Language = "python"
    do classMethod.%Save()
}

}
