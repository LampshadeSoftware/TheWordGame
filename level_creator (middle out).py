import itertools
import string
import time


# node object: stores the current depth and the path to get to the current word
class Node:

	def __init__(self, word, depth, parent_node):
		self.depth = depth
		self.word = word
		self.parent_node = parent_node

	def get_depth(self):
		return self.depth

	def get_word(self):
		return self.word

	def get_parent(self):
		return self.parent_node

	def __str__(self):
		word = "".join(self.get_word())
		if self.get_parent() is None:
			return word
		return str(self.get_parent()) + " -> " + word

	def __eq__(self, other):
		return self.get_word() == other.get_word() and self.get_depth() > other.get_depth()


def print_list(arr):
	print = ""
	length = len(arr)
	for i in range(len(arr)):
		item = arr[i]
		if type(item) == list:
			print += print_list(item)
		else:
			print += str(item)
			if i < length-1:
				print += ", "
	print += "\n"
	return print


# finds all the possible moves on a given word and returns their nodes
def get_perms(node):
	word = node.get_word()
	perms = []

	# get adds and removes
	for i in range(len(word)+1):
		for letter in alpha:
			# get all adds
			add_perm = word.copy()
			add_perm.insert(i, letter)
			if "".join(add_perm) in dictionary:
				perms.append(Node(add_perm, node.get_depth()+1, node))

			if i < len(word):
				# get all subs
				if word[i] != letter:
					sub_perm = word.copy()
					sub_perm[i] = letter
					if "".join(sub_perm) in dictionary:
						perms.append(Node(sub_perm, node.get_depth()+1, node))

		# get all removes
		if i < len(word):
			remove_perm = word.copy()
			del remove_perm[i]
			if "".join(remove_perm) in dictionary:
				perms.append(Node(remove_perm, node.get_depth()+1, node))

	# get all rearranges
	possible_rearranges = itertools.permutations(word)
	for rearrange_perm in possible_rearranges:
		rearrange_perm = list(rearrange_perm)
		if "".join(rearrange_perm) in dictionary:
			if rearrange_perm != word:
				perms.append(Node(rearrange_perm, node.get_depth()+1, node))

	# returns a list of Node objects containing all possible moves off the given parameter: word
	return perms


# creates the level
def turn(node):
	print(node.get_depth())
	# get permutations of the current word
	perms = get_perms(node)

	# checks if each of the perms has already been played
	for perm in perms.copy():
		# deals for situations when the permutation has already been played at a shallower depth
		for nodes_at_depth in nodes:
			if perm in nodes_at_depth:
				perms.remove(perm)

	# stop if current depth is within the desired move radius
	current_depth = node.get_depth() + 1
	try:
		nodes[current_depth].extend(perms)
	except IndexError:
		nodes.append(perms)

# start timer
start = time.time()

with open("dictionary.txt") as f:
	dictionary = [x.strip('\n') for x in f.readlines()]
alpha = string.ascii_lowercase
start_word = list("fat")
num_moves = 3  # set the "move radius"
nodes = [[Node(start_word, 0, None)]]  # all the nodes. Index corresponds to the depth

# starts creating the level
for depth in range(num_moves):
	for node in nodes[depth]:
		turn(node)

# print the levels
end = time.time()
for node in nodes[-1]:
	print(node)

print("\ntime:", round(end - start, 2), "seconds")
print("possibilities:", len(nodes[-1]))
