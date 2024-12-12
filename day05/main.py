from math import floor


def readingUpdatesFile(filename: str) -> list[list[str]]:
    list1: list[list[str]] = []

    with open(filename) as f:
        lines = f.read().splitlines()
    for line in lines:
        elements = line.split(",")
        list1.append(elements)
    return list1


def readingOrderRulesFile(filename: str) -> list[tuple[str, str]]:
    orderRules: list[tuple[str, str]] = []

    with open(filename) as f:
        lines = f.read().splitlines()
    for line in lines:
        parent, child = line.split("|")
        orderRules.append((parent, child))
    return orderRules


def orderingRules(orderRules: list[tuple[str, str]]) -> dict[str, list[str]]:
    # orderedList: list[str] = []
    parentsPerChild: dict[str, list[str]] = {}
    for k, v in orderRules:
        if v in parentsPerChild.keys():
            parentsPerChild[v].append(k)
        else:
            parentsPerChild[v] = [k]

    return parentsPerChild


def validateUpdate(update: list[str], orderedRules: dict[str, list[str]]) -> bool:
    for idx, updateElm in enumerate(update):
        previousUpdateElements: list[str] = update[:idx]
        for previousElm in previousUpdateElements:
            try:
                if previousElm not in orderedRules[updateElm]:
                    return False
            except KeyError:
                return False

    return True


def reorderUpdate(update: list[str], orderedRules: dict[str, list[str]]) -> list[str]:
    print(update)
    orderedUpdate: list[str] = []
    for idx, updateElm in enumerate(update):
        previousUpdateElements: list[str] = update[:idx]
        print(idx, updateElm, previousUpdateElements)
        for previousElm in previousUpdateElements:
            if (
                updateElm not in orderedRules.keys()
                or previousElm not in orderedRules[updateElm]
            ):
                orderedUpdate.insert(len(orderedUpdate) - 1, updateElm)
                break
        else:
            orderedUpdate.append(updateElm)

    print(orderedUpdate)
    return orderedUpdate


def exercise01() -> None:
    updatesToValidate = readingUpdatesFile("updatesInput.txt")
    print(updatesToValidate)
    rules = readingOrderRulesFile("pageOrderingInput.txt")
    orderedRules = orderingRules(rules)
    print(orderedRules)

    middleElementSum: int = 0
    for update in updatesToValidate:
        if validateUpdate(update, orderedRules):
            middleElm = update[int(floor(len(update) / 2))]
            middleElementSum += int(middleElm)

    print("solution day01/exercise01", middleElementSum)


def exercise02() -> None:
    updatesToValidate = readingUpdatesFile("updatesInput.txt")
    print(updatesToValidate)
    rules = readingOrderRulesFile("pageOrderingInput.txt")
    orderedRules = orderingRules(rules)
    print(orderedRules)

    middleElementSum: int = 0
    for update in updatesToValidate:
        if not validateUpdate(update, orderedRules):
            while validateUpdate(update, orderedRules) is not True:
                update = reorderUpdate(update, orderedRules)
            middleElm = update[int(floor(len(update) / 2))]
            middleElementSum += int(middleElm)

    print("solution day01/exercise02", middleElementSum)


if __name__ == "__main__":
    # exercise01()
    exercise02()
