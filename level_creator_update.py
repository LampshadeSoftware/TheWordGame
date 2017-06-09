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
		if perm in already_played:
			perms.remove(perm)

	# only add the words that haven't been played before
	already_played.extend(perms)

	# stop if current depth is within the desired move radius
	current_depth = node.get_depth() + 1
	if current_depth >= num_moves:
		target_nodes.extend(perms)
		return

	# repeat the process on each permutation
	for new_node in perms:
		turn(new_node)


# start timer
start = time.time()

with open("dictionary.txt") as f:
	dictionary = [x.strip('\n') for x in f.readlines()]
alpha = string.ascii_lowercase
start_word = list("fat")
num_moves = 4  # set the "move radius"
already_played = [Node(start_word, 0, None)]  # records all words that have already been played before
target_nodes = []  # all the nodes that have words on the "move radius"

# starts creating the level
turn(Node(start_word, 0, None))  # set the first turn with a depth of 0

print("time:", round(time.time() - start, 2), "seconds")
print("possibilities:", len(target_nodes))
for node in target_nodes:
	print(node)
