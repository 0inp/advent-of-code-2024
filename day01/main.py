def readingFile(filename: str) -> tuple[list[int], list[int]]:
    list1: list[int] = []
    list2: list[int] = []

    with open(filename) as f:
        lines = f.read().splitlines()
    for line in lines:
        elements = line.split(",")
        list1.append(int(elements[0]))
        list2.append(int(elements[1]))
    return list1, list2


def exercise01() -> None:
    list1, list2 = readingFile("input.txt")

    list1.sort()
    list2.sort()
    totalDistance: int = 0
    for idx, elm in enumerate(list1):
        idxDifference = abs(elm - list2[idx])
        totalDistance += idxDifference
    print("solution day01/exercise01", totalDistance)


def exercise02() -> None:
    list1, list2 = readingFile("input.txt")
    totalSimilarity: int = 0
    for elm in list1:
        count = list2.count(elm)
        totalSimilarity += count * elm
    print("solution day01/exercise02", totalSimilarity)


if __name__ == "__main__":
    # exercise01()
    exercise02()
