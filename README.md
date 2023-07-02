# IRIS-GPT

## Introduction

The IRIS-GPT project demonstrates how to use the GPT chat with Intersystems IRIS by configuring TXT prompt engines globally and defining GPT behavior. It empowers code changes and creations in the system through natural language processing.

There are two pre-programmed prompt engines in this project:

1. **Rules Interoperability Engine:** This engine assists in creating and maintaining rules for interoperability in Intersystems IRIS. It allows interaction with GPT to obtain suggestions and assistance in defining the rules.

2. **Python ClassMethod Engine:** This engine facilitates the creation and maintenance of Python ClassMethods in Intersystems IRIS. It utilizes GPT to provide coding assistance and suggestions to enhance the implementation of methods.

## Prerequisites
Make sure you have : 
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
- [Docker desktop](https://www.docker.com/products/docker-desktop).
- [openai api key](https://platform.openai.com/account/api-keys).

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/Davi-Massaru/interoperability_GPT.git
```

Replace a <OPENIA.key> tag to your openia api key on iris.script

```
Set ^GPT.openAI.APIKeys = "<OPENIA.key>"
```

You can change a GPT.model, change the iris.script. defined "gpt-3.5-turbo-0613"

```
Set ^GPT.model = "gpt-3.5-turbo-0613"
```

Open the terminal in this directory and run:

```
$ docker-compose build && docker-compose up -d
```

## Creating Engines 

To create new prompt engines, you can create a new TXT file in the project root or inside the Docker container. These files will dictate the behavior of the GPT chat.

After producing the TXT file, configure the global in the following structure:

 - ^GPT.engine("<ENGINE_NAME>"): path to the prompt engine file text.
 - ^GPT.engine.initial("<ENGINE_NAME>"): initial instructions.

For example, use ^GPT.engine as follows:

```
Set ^GPT.engine("implementation") = "/home/irisowner/dev/prompt-implementation-engineer.txt"
Set ^GPT.engine.initial("implementation") = "Write pyhton code"
```

In this example, you created a new engine called "implementation." All instructions sent to the GPT chat will start with the instruction "Write Python code."

Once you've completed these steps, simply execute ##class(dc.GPT.Engine).generate(<message>,"<ENGINE_NAME>") where <message> is the input provided by the user.

## Application Examples: 

In this repository, you can find examples of various pre-programmed prompt engines:

Rule Interoperability Engine: This engine assists with creating and maintaining rules for interoperability in Intersystems IRIS.

Python ClassMethod Engine: This engine facilitates the creation and maintenance of Python ClassMethods in Intersystems IRIS.

To test:

- Python ClassMethod Engine
    - ```##class(dc.Dict.GenerateMethod).Run(className, method, formalSpec, mensage)```: to generate or override a new ClassMethod in python in the informed class, using formalSpec as parameters.

    - ```##class(dc.Dict.GenerateMethod).FixBug(className, method, mensage)```: to update a ClassMethod in python in the informed class, taking into account the current implementation.

- Rule Interoperability

    - ```##class(dc.Dict.GenerateRule).Run(className, mensage)```: to generate or override a new RuleDefinition in the informed class.

    - ```##class(dc.Dict.GenerateMethod).Fix(className, mensage)```: to update a RuleDefinition in python in the informed class, taking into account the current implementation

    