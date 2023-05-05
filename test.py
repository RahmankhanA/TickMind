# def min_operations(arr):
#     # find the median of the array
#     median = sorted(arr)[len(arr) // 2]
#     # print(median)

#     # calculate the total number of operations needed
#     total_ops = sum(abs(num - median) for num in arr)

#     return [total_ops, median]

# # example usage
# arr = [1, 2, 4, 7, 9]
# ops = min_operations(arr)
# print(ops)  # output: 10



# Function to calculate the cost for a single query
def costForSingleQuery(arr, number, cost_dict):
    if number in cost_dict:
        return cost_dict[number]
    else:
        cost = sum(abs(number - i) for i in arr)
        cost_dict[number] = cost
        return cost



# Get input values for array and queries
# n, m = map(int, input().split())
# arr = list(map(int, input().split()))
# queries = list(map(int, input().split()))



arr=[1, 2, 3, 4, 5]
queries=[ 5, 2, 1]
# Calculate the cost for each query and store in a list
cost=[]
cost1, median=min_operations(arr)
arrlen=len(arr)
print(cost1)
# cost = [(arrlen * abs(query - median)+cost1) for query in queries]
for query in queries:
   data= (arrlen * abs(query - median))
   print(data)
   cost.append(data)


print(*cost)