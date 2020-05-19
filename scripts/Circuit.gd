class_name Circuit
extends Resource
# Breadboard abstraction to represent the whole circuit

var breadboard : Dictionary
var cycle_number = 0

# Init breadboard as grid from 1 to bus_length
func _init():
	for point_y in range(1, BB.BUS_LENGTH+1):
		for point_x in range(1, (BB.BUS_WIDTH*2)+1):
			breadboard[Vector2(point_x, point_y)] = CircuitNode.new()
			if point_x > 1 and point_x <= BB.BUS_WIDTH:
				breadboard[Vector2(point_x, point_y)].row_neighbors.append(Vector2(point_x-1, point_y))
				breadboard[Vector2(point_x-1, point_y)].row_neighbors.append(Vector2(point_x, point_y))
			elif point_x > BB.BUS_WIDTH + 1 and point_x <= BB.BUS_WIDTH*2:
				breadboard[Vector2(point_x, point_y)].row_neighbors.append(Vector2(point_x-1, point_y))
				breadboard[Vector2(point_x-1, point_y)].row_neighbors.append(Vector2(point_x, point_y))


func _ready():
	pass

func get_node_list():
	var node_list = []
	
	for addr in breadboard:
		if breadboard[addr].comp_connected:
			node_list.append(addr)
	return node_list

# Iterate through all connected components and return on dictionary with nodes 
# 	as keys and ajdacents as values
func get_connection_list():
	var connection_list : Dictionary = {}
	
	for addr in breadboard:
		if breadboard[addr].comp_connected:
			if(not connection_list.has(addr)):
				connection_list[addr] = []
				var visit_list = []
				add_row_neighbors(addr, addr, visit_list, connection_list)
				if breadboard[addr].comp_connected.leads["A"] == addr:
					connection_list[addr].append(breadboard[addr].comp_connected.leads["B"])
				elif breadboard[addr].comp_connected.leads["B"] == addr:
					connection_list[addr].append(breadboard[addr].comp_connected.leads["A"])
	return connection_list

func add_row_neighbors(o_addr, cur_addr, visit_list, connection_list):
	if not visit_list.has(cur_addr):
		visit_list.append(cur_addr)
		if breadboard[cur_addr].comp_connected and not o_addr == cur_addr:
			connection_list[o_addr].append(cur_addr)
			return
		for neighbor in breadboard[cur_addr].row_neighbors:
			add_row_neighbors(o_addr, neighbor, visit_list, connection_list)

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
		if breadboard[addr].comp_connected:
			if(not adj_matrix.has(addr)):
				var adj = {}
				var visit_list = []
				m_add_row_neighbors(addr, addr, visit_list, adj)
				if breadboard[addr].comp_connected.leads["A"] == addr:
					adj[breadboard[addr].comp_connected.leads["B"]] = 1
				elif breadboard[addr].comp_connected.leads["B"] == addr:
					adj[breadboard[addr].comp_connected.leads["A"]] = 1
				for node in node_list:
					if not adj.keys().has(node):
						adj[node] = 0
				adj_matrix[addr] = adj
	return adj_matrix

func m_add_row_neighbors(o_addr, c_addr, visit_list, adj):
	if not visit_list.has(c_addr):
		visit_list.append(c_addr)
		if breadboard[c_addr].comp_connected and not o_addr == c_addr:
			adj[c_addr] = 1
			return
		for neighbor in breadboard[c_addr].row_neighbors:
			m_add_row_neighbors(o_addr, neighbor, visit_list, adj)
	pass

func m_get_spanning_tree():
	var new_list = []
	var node_list = get_node_list()
	var adj_matrix = m_get_connection_list()
	var new_matrix = {}
	
	for adj in adj_matrix:
		for jda in adj_matrix:
			if adj_matrix[adj][jda] == 1 and not new_list.has(jda):
				if not new_matrix.has(adj):
					new_matrix[adj] = {}
				if not new_matrix.has(jda):
					new_matrix[jda] = {}
				new_matrix[adj][jda] = 1
				new_matrix[jda][adj] = 1
				new_list.append(jda)
			if adj_matrix[adj][jda] == 1 and not new_list.has(adj):
				if not new_matrix.has(adj):
					new_matrix[adj] = {}
				if not new_matrix.has(jda):
					new_matrix[jda] = {}
				new_matrix[adj][jda] = 1
				new_matrix[jda][adj] = 1
				new_list.append(adj)
		for node in node_list:
			if not new_matrix[adj].has(node):
				new_matrix[adj][node] = 0
	return new_matrix
	pass

func m_get_loops():
	var spanning_matrix = m_get_spanning_tree()
	var adj_matrix = m_get_connection_list()
	var node_list = get_node_list()
	
	for nx in node_list:
		for ny in node_list:
			pass
	
	pass
