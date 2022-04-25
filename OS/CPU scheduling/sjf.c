/*
Name: --name--
Roll Number: --rollno--
Class: CS5B
*/
// SJF CPU SCHEDULING
#include<stdio.h>

struct pris {
	int pid, atime, btime, ctime, wtime, tatime;
	short check;
};

int main () {

	int i, j, k, n, t, twtime = 0, ttatime;
	printf ("SJF SCHEDULING\n\nEnter the no. of processes -> ");
	scanf ("%d", &n);
	
	struct pris p[n];
	int q[n];

	printf ("\nInput AT and BT ->\n\n\tA.T\tB.T\n");
	for (i = 0; i < n; i++) {
		p[i].pid = i; p[i].check = 0; p[i].ctime = 0; p[i].wtime = 0; p[i].tatime = 0; q[i] = -1;
		printf ("P%d\t", p[i].pid);
		scanf ("%d %d", &p[i].atime, &p[i].btime);
	}


	t = 0; j = 0; k = 0;
	while (j != n) {

		printf ("\nt updated to %d ", t);
		for (i = 0; i < n; i++) {
			if (t >= p[i].atime && p[i].check != 1) {
				q[j] = i;
				p[i].check = 1;
				printf (" P%d ", q[j]);
				j++;
			}
		}
		printf ("arrived! ");

		int temp;
		for (i = k; i < j; i++) {
			for (int l = i+1; l < j; l++) {
				if (p[q[i]].btime > p[q[l]].btime) {
					temp = q[i];
					q[i] = q[l];
					q[l] = temp;
				}
				else if (p[q[i]].btime == p[q[l]].btime) {
					if (p[q[i]].atime > p[q[l]].atime) {
						temp = q[i];
						q[i] = q[l];
						q[l] = temp;
					}
				}
			}
		}

		t += p[q[k]].btime;
		p[q[k]].ctime = t;
		p[q[k]].tatime = p[q[k]].ctime - p[q[k]].atime;
		p[q[k]].wtime = p[q[k]].tatime - p[q[k]].btime;
		twtime += p[q[k]].wtime;
		ttatime += p[q[k]].tatime;
		printf ("\nP%d executed!", p[q[k]].pid);
		k++;

	}

	for (i = k; i < n; i++) {
		printf ("\nt updated to %d ", t);
		t += p[q[i]].btime;
		p[q[i]].ctime = t;
		p[q[i]].tatime = p[q[i]].ctime - p[q[i]].atime;
		p[q[i]].wtime = p[q[i]].tatime - p[q[i]].btime;
		twtime += p[q[i]].wtime;
		ttatime += p[q[i]].tatime;
		printf ("\nP%d executed!", p[q[i]].pid);
	}


	printf ("\n\n\tA.T\tB.T\tC.T\tT.A.T\tW.T\n");
	for (i = 0; i < n; i++)
		printf ("P%d\t%d\t%d\t%d\t%d\t%d\n", p[q[i]].pid, p[q[i]].atime, p[q[i]].btime, p[q[i]].ctime, p[q[i]].tatime, p[q[i]].wtime);
	printf("\nAverage turn around time: %f\n", (float)ttatime/n);
    printf("Average waiting time: %f\n\n", (float)twtime/n);
    return 0;
}
