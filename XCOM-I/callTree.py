#!/usr/bin/env python3
'''
License:    The author (Ronald S. Burkey) declares that this program
            is in the Public Domain (U.S. law) and may be used or 
            modified for any purpose whatever without licensing.
Filename:   callTree.py
Purpose:    This is used to eliminate PROCEDURE definitions for PROCEDUREs 
            that are never CALL'ed.
Reference:  http://www.ibibio.org/apollo/Shuttle.html
Mods:       2024-05-02 RSB  Began.
'''

from auxiliary import walkModel

# For each PROCEDURE defined at the global level (versus being an embedded
# PROCEDURE), determines how many places it's called from, other than its own
# embedded procedures.  In order to do this, it must walk the entire scope
# hierarchy.  Having done that, it proceeds to eliminate all PROCEDUREs which
# are not called from anywhere.
def callTree(globalScope):
    
    procedureNames = {}
    
    def checkScope(scope, extra):
        
        def checkLine(line):
            
            def checkExpression(expression):
                if expression == None:
                    return
                if "token" in expression:
                    token = expression["token"]
                    if "identifier" in token:
                        identifier = token["identifier"]
                        if identifier in procedureNames:
                            procedureNames[identifier]["anyCalls"] += 1
                if "children" in expression:
                    for child in expression["children"]:
                        checkExpression(child)
            
            if "ASSIGN" in line:
                checkExpression(line["RHS"])
                for LHS in line["LHS"]:
                    checkExpression(LHS)
            elif "FOR" in line:
                checkExpression(line["from"])
                checkExpression(line["to"])
                checkExpression(line["by"])
            elif "WHILE" in line:
                checkExpression(line["WHILE"])
            elif "UNTIL" in line:
                checkExpression(line["UNTIL"])
            elif "IF" in line:
                checkExpression(line["IF"])
            elif "RETURN" in line:
                checkExpression(line["RETURN"])
            elif "CALL" in line:
                name = line["CALL"]
                if name in procedureNames:
                    procedureNames[name]["anyCalls"] += 1
                for parameter in line["parameters"]:
                    checkExpression(parameter)
            elif "CASE" in line:
                checkExpression(line["CASE"])
                
        for line in scope["code"]:
            checkLine(line)
        return None
    
    # Setup.
    for identifier in globalScope["variables"]:
        attributes = globalScope["variables"][identifier]
        if "PROCEDURE" in attributes:
            procedureNames[identifier] = attributes
            attributes["anyCalls"] = 0
    #print(list(procedureNames))
    # Walk the scope hierarchy.
    walkModel(globalScope, checkScope)
    
    junkProcs = []
    for j in ["COMPACTIFY", "RECORD_LINK"]:
        if j in globalScope["variables"] and \
                "PROCEDURE" in globalScope["variables"][j]:
            junkProcs.append(j)
    for procedure in procedureNames:
        if procedureNames[procedure]["anyCalls"] == 0:
            junkProcs.append(procedure)
    if len(junkProcs) != 0:
        print("No code is generated for the following unused or overridden PROCEDURE(s):")
        for j in junkProcs:
            print("\t" + j)
            if j in globalScope["variables"]:
                globalScope["variables"].pop(j)
        children = globalScope["children"]
        #print(len(children))
        for j in range(len(children)-1, -1, -1):
            if children[j]["symbol"] in junkProcs:
                del children[j]
        #print(len(junkProcs))
        #print(len(children))
            