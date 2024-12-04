import re


def readingFile(filename: str) -> str:
    with open(filename) as f:
        line = f.read().splitlines()
    return line[0]


def computeMultplication(multiplicationCommand: str) -> int:
    firstFactor, secondFactor = re.findall(r"\d{1,3}", multiplicationCommand)
    result = int(firstFactor) * int(secondFactor)
    return result


def findClosestBefore(instrPositions: dict[str, list[int]], pos: int) -> str:
    closestDoPosition = None
    for i in instrPositions["do"]:
        if i < pos:
            closestDoPosition = i
        if i > pos:
            break
    closestDontPosition = None
    for i in instrPositions["dont"]:
        if i < pos:
            closestDontPosition = i
        if i > pos:
            break
    print("closest DO : ", closestDoPosition)
    print("closest DONT : ", closestDontPosition)
    if closestDoPosition is None:
        return "do"
    if closestDontPosition is None:
        return "do"
    if closestDoPosition > closestDontPosition:
        return "do"
    else:
        return "dont"


def exercise01() -> None:
    line = readingFile("input.txt")
    totalMultiplications = 0
    doDontPositions: dict[str, list[int]] = {"do": [0], "dont": []}
    for m in re.finditer(r"(?:don't\(\)|do\(\))", line):
        if m.group(0) == "do()":
            doDontPositions["do"].append(m.end() - 1)
        if m.group(0) == "don't()":
            doDontPositions["dont"].append(m.end() - 1)
    print("doDontPositions : ", doDontPositions)
    for m in re.finditer(r"(mul\([0-9]{1,3}\,[0-9]{1,3}\))", line):
        matchPosition = m.start()
        print("mul match start pos : ", matchPosition)
        closestDoDontInstr = findClosestBefore(doDontPositions, matchPosition)
        print("closest lower instr : ", closestDoDontInstr)
        if closestDoDontInstr == "do":
            multiplicationResult = computeMultplication(m.group(0))
            totalMultiplications += multiplicationResult
            print("total : ", totalMultiplications)

    print("solution day01/exercise01", totalMultiplications)


if __name__ == "__main__":
    exercise01()
    # exercise02()
