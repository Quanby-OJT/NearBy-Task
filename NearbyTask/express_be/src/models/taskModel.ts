import {supabase} from "../config/configuration";

class Tasks{
    static async create(tasks: {task_title: string, task_description: string, task_begin_date: Date, duration: number, period: string, contact_price: number, urgent: boolean, remarks: string}){
        const {data, error} = await supabase.from('tasks').insert([tasks])

        if (error) throw new Error(error.message);

        return data
    }

    static async update(tasks: {task_title: string, task_description: string, task_begin_date: Date, duration: number, period: string, contact_price: number, urgent: boolean, remarks: string}, task_id: {task_id: number}){
        const {data, error} = await supabase.from('tasks').update([tasks]).eq('task_id', [task_id])

        if (error) throw new Error(error.message);

        return data
    }
}

export {Tasks}