Class dc.GPT.Engine Extends %RegisteredObject [ Language = python ]
{

ClassMethod generate(command, engine = "implementation") As %String
{
    import json
    import iris
    import requests

    payload = {
            "model": iris.gref("GPT.model")[None],
            "messages": [
                {
                    "role": "system",
                    "content": iris.cls("dc.GPT.Engine").ReadPromptEngine(engine)
                }
            ]
        }
    
    request_header = {
        "Authorization": "Bearer " + iris.gref("GPT.openAI.APIKeys")[None],
        "Content-Type": "application/json"
    }

    initial_command = iris.cls("dc.GPT.Engine").ReadPromptEngineInitial(engine)
    payload["messages"].append({"role": "user", "content": f'{initial_command}, without any explanation, that: {command}'})

    json_payload = json.dumps(payload)

    url = "https://api.openai.com/v1/chat/completions"
    response = requests.post(url, headers=request_header, data=json_payload)

    if response.status_code == 200:
        code =  iris.cls("dc.GPT.Engine").ExtractCodeFromResponse(response.json())
        return f"{code}"
    
    return "None"
}

ClassMethod ExtractCodeFromResponse(response) As %Status
{
    import iris
    try:
        choices = response.get("choices")
        if choices and len(choices) > 0:
            first_choice = choices[0]
            message = first_choice.get("message")
            if message:
                content = message.get("content")
                if content:
                    return iris.cls("dc.GPT.Engine").ExtractCodeFromContent(content)
    except Exception as e:
        print("[ChatGPT] Error: Unable to parse response:", str(e))
    return None
}

ClassMethod ExtractCodeFromContent(content) As %Status
{
    parts = content.split("```")
    if len(parts) >= 2:
        return parts[1]
    return content
}

ClassMethod ReadPromptEngine(engine) As %String
{
    import iris
    GPT_engine = iris.gref('GPT.engine')

    if engine == "": engine = "implementation"
    engine_file_path = GPT_engine[engine] or GPT_engine["implementation"]

    with open(engine_file_path, 'r') as file:
        file_content = file.read()
        file.close()
        content_string = str(file_content)

    return content_string
}

ClassMethod ReadPromptEngineInitial(engine) As %String
{
    import iris
    GPT_engine_initial = iris.gref('GPT.engine.initial')

    if engine == "": engine = "implementation"
    return GPT_engine_initial[engine] or GPT_engine_initial["implementation"]
}

}
