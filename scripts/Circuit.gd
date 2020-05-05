class_name Circuit
extends Resource
# Breadboard abstraction to represent the whole circuit

var breadboard : Dictionary
var cycle_number = 0

func _init():
	breadboard[BB.BUS_A_NEGATIVE] = CircuitRow.new(50)
	breadboard[BB.BUS_A_POSITIVE] = CircuitRow.new(50)

	breadboard[BB.BUS_B_NEGATIVE] = CircuitRow.new(50)
	breadboard[BB.BUS_B_POSITIVE] = CircuitRow.new(50)

	for row in range(BB.BUS_LENGTH):
		breadboard[Vector2(BB.BUS_A, row)] = CircuitRow.new(5)
		breadboard[Vector2(BB.BUS_B, row)] = CircuitRow.new(5)


func _ready():
	pass


# Iterate through all connected components and return on dictionary with nodes as keys and ajdacents as values
func get_connection_list():
	var connection_list : Dictionary = {}

	for addr in breadboard:
		if breadboard[addr].row.size() > 0:
			if(not connection_list.has(addr)):
				var adj = []
				for comp in breadboard[addr].row:
					if comp.leads["A"] == addr:
						adj.append(comp.leads["B"])
					elif comp.leads["B"] == addr:
						adj.append(comp.leads["A"])
				connection_list[addr] = adj

	return connection_list


func get_loops():
	var loop_list = {}
	var color = {}
	var mark = {}
	var parents = {}
	var comp_list = get_connection_list()
	cycle_number = 0

	dfs(comp_list.keys().front(), null, color, mark, parents, comp_list)

	for comp in comp_list:
		if not mark.has(comp):
			mark[comp] = []
		if mark[comp].size() > 0:
			for cycle in mark[comp]:
				if not loop_list.has(cycle):
					loop_list[cycle] = []
				loop_list[cycle].append(comp)

	return loop_list

func dfs(current, previous, color, mark, parents, comp_list):

	if color.has(current):
		if color[current] == 2:
			return

		if color[current] == 1:
			cycle_number += 1
			var cur = previous
			if not mark.has(cur):
				mark[cur] = []
			mark[cur].append(cycle_number)

			while cur != current:
				cur = parents[cur]
				if not mark.has(cur):
					mark[cur] = []
				mark[cur].append(cycle_number)
			return

	parents[current] = previous

	color[current] = 1

	for adj in comp_list[current]:
		if adj == parents[current]:
			continue
		dfs(adj, current, color, mark, parents, comp_list)

	color[current] = 2
