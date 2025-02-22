import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { DemoService } from 'src/app/services/demo.service';

@Component({
  selector: 'app-user-communication',
  imports: [CommonModule],
  templateUrl: './user-communication.component.html',
  styleUrl: './user-communication.component.css',
})
export class UserCommunicationComponent implements OnInit {
  users: any[] = [];

  constructor(private userService: DemoService) {}

  ngOnInit(): void {
    // this.userService.getData().subscribe((response) => {
    //   this.users = response;
    // });

    this.userService.getAllUsers().subscribe(
      (response) => {
        this.users = response.users;
      },
      (error) => {
        console.error('Error fetching users:', error);
      },
    );
  }

  // fetchUsers(): void {
  //   this.userService.getAllUsers().subscribe(
  //     (response) => {
  //       this.users = response.users;
  //     },
  //     (error) => {
  //       console.error('Error fetching users:', error);
  //     },
  //   );
  // }
}
