global class Jobs_Daily implements Schedulable {
	global void execute(SchedulableContext sc) {
		Jobs.execute('Daily');
	}
}