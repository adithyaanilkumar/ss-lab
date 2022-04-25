/*
Name: --name--
Roll Number: --rollno--
Class: CS5B
*/
//Round Robin CPU SCHEDULING 
#include<stdio.h>
#include<stdlib.h>

struct rrs {
	int pid, atime, btime, tempb, ctime, tatime, wtime;
	short isTraversed;
};

void main () {
	
	int i, j, k, n, count = 0, qt, curr_time = 0, arriv = 0, leucpid; 
	float ttatime = 0, twtime = 0;

	printf ("RRS CPU SCHEDULING\n\nEnter the no. of processes -> ");
	scanf ("%d", &n);
	
	struct rrs p[n];
	// dynamic allocation for ready queue
	int *q;
	q = (int *)malloc (sizeof (int));

	printf ("\nEnter the values -> \n");
	printf ("P[pid]\tAT\tBT\n");
	for (i = 0; i < n; i++) {

		p[i].isTraversed = 0;
		p[i].pid = i;
		printf ("P[%d]\t", p[i].pid);
		scanf ("%d %d", &p[i].atime, &p[i].btime); 
		p[i].tempb = p[i].btime; // burstTime left after preemption stored in p[i].tempb
		
	}
	
	printf ("\nEnter the time quantum -> ");
	scanf ("%d", &qt);

	j = 0; // ready queue index
	k = 0; // completed process index in ready queue 

	leucpid = -1; // stores id of last executed uncompleted process
	
	printf ("\nP\tAT\tBT\tCT\tTAT\tWT");
	while (count != n) { 
		
		if (arriv < n) 
			for (i = 0; i < n; i++) 
				if (p[i].isTraversed == 0) // checks whether a process is traversed once to avoid repetition of processes in the ready queue
					if (curr_time >= p[i].atime) { 
						q[j] = i;
						p[q[j]].isTraversed = 1;
						arriv++;
						j++;
					}

		if (leucpid != -1) { // for storing id of the preempted process
			q[j] = leucpid;
			j++;
		}

		if (p[q[k]].tempb <= qt) {

			curr_time += p[q[k]].tempb;
			p[q[k]].tempb = 0;

			p[q[k]].ctime = curr_time;
			p[q[k]].tatime = p[q[k]].ctime - p[q[k]].atime;
			p[q[k]].wtime = p[q[k]].tatime - p[q[k]].btime;
			ttatime += p[q[k]].tatime;
			twtime += p[q[k]].wtime;

			printf ("\nP%d\t%d\t%d\t%d\t%d\t%d", p[q[k]].pid, p[q[k]].atime, p[q[k]].btime, p[q[k]].ctime, p[q[k]].tatime, p[q[k]].wtime);

			leucpid = -1;
			k++;
			count++;
		}
		else if (p[q[k]].tempb > qt) {

			curr_time += qt;
			p[q[k]].tempb -= qt;

			leucpid = p[q[k]].pid;

			k++;

		}

	}

	printf ("\n\nAverage Turnaround Time: %f", ttatime/n);
	printf ("\nAverage Waiting Time: %f\n\n", twtime/n);

}
