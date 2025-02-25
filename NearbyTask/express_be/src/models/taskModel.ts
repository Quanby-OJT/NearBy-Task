import {supabase} from "../config/configuration";

class UserModel {
  
  async createUser(description: string, duration: string, job_title: string, urgency: string, location: string, num_of_days: number, specialization: string, contact_price: string, remarks: string, task_begin_date: string) {
    const { data, error } = await supabase.from('job_post').insert([
      {
        task_title: job_title,
        task_description: description,
        duration: duration,
        contact_price: contact_price, 
        urgent: urgency, 
        remarks: remarks, 
        task_begin_date: task_begin_date,
        period: num_of_days, 
        location: location,
        specialization: specialization,
      },
    ]);

    if (error) throw new Error(error.message);
    return data;
  }
}

const userModel = new UserModel();
export default userModel;