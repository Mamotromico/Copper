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

func get_node_list():
	var node_list = []
	
	for addr in breadboard:
		if breadboard[addr].row.size() >0:
			node_list.append(addr)
	return node_list

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
					if comp.leads["B"] == addr:
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

func m_get_connection_list():
	var adj_matrix = {}
	var node_list = get_node_list()
	for addr in breadboard:
		if breadboard[addr].row.size() > 0:
			if(not adj_matrix.has(addr)):
				var adj = {}
				for comp in breadboard[addr].row:
					if comp.leads["A"] == addr:
						adj[comp.leads["B"]] = 1
					elif comp.leads["B"] == addr:
						adj[comp.leads["A"]] = 1
				for node in node_list:
					if not adj.keys().has(node):
						adj[node] = 0
				adj_matrix[addr] = adj
	return adj_matrix

func m_get_spanning_tree():
	var new_list = []
	var adj_matrix = m_get_connection_list()
	var new_matrix = {}
	
	for adj in adj_matrix:
		for jda in adj:
			if adj_matrix[adj][jda] == 1 and not new_list.has(jda):
				new_matrix[adj][jda] = 1
				new_matrix[jda][adj] = 1
				new_list.append(jda)
			if adj_matrix[adj][jda] == 1 and not new_list.has(adj):
				new_matrix[adj][jda] = 1
				new_matrix[jda][adj] = 1
				new_list.append(adj)
				
	return new_matrix
	pass

func m_get_loops():
	pass
