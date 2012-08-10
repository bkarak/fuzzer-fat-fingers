import data_structures

class TaskStatistics(object):
	def __init__(self):
		super(TaskStatistics, self).__init__()
		self.__tasks = {}

		# parsing - naive, breaks often
		fp = open('total-lines-tasks.text', 'r')

		for l in fp:
			lt = l.split(' ')
			ltt = lt[1].split('/')
			lttt = ltt[2].split('.')

			_file_loc = int(lt[0].strip())			
			_file_task = ltt[1].strip()
			_file_language = lttt[1].strip()

			dict_count = self.__tasks.get(_file_task, data_structures.DictCount())
			if _file_loc == 0:
				_file_loc = 1
			dict_count.add(_file_language, val=_file_loc)
			self.__tasks[_file_task] = dict_count

		fp.close()

	def get_loc(self, task_name, language):
		dict_count = self.__tasks.get(task_name, data_structures.DictCount())
		return dict_count.get_value(language)
