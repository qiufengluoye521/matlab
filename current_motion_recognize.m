function [rec_result]=current_motion_recognize(ppg_buf,gsensor_buf,ppg_max_peak,gsensor_max_peak)

    gsensor_2_times_flags = 0;
    max_peak_num = ppg_max_peak(5,20).pre_num - 44;
    is_disturb_flag = 4;
    for i = max_peak_num:-1:1
        if ppg_buf(i) < (ppg_max_peak(5,20).pre_value*2/3)
            is_disturb_flag = 0;
            break;
        end
    end
    
    for i = max_peak_num:1:max_peak_num+10
        if ppg_buf(i) < (ppg_max_peak(5,20).pre_value*2/3)
            is_disturb_flag = 0;
            break;
        end
    end

    rec_result = is_disturb_flag;
    
    % 如果些帧未被识别成干扰信号，则进入下面的识别
    if(rec_result ~= 4)    
        if (gsensor_max_peak(5,20).pre_num / gsensor_max_peak(5,20).pre_num >= 0.48)  ...
                || (gsensor_max_peak(5,20).pre_num / gsensor_max_peak(5,20).pre_num <= 2.2)
            gsensor_2_times_flags = 1;
        end

        % gsensor 的最大值小于80，认为是静止状态
        if gsensor_max_peak(5,20).pre_value < 80
            rec_result = 0;
        elseif (gsensor_max_peak(5,20).pre_value < 150) && (gsensor_2_times_flags == 1)
            rec_result = 2;
        elseif (gsensor_max_peak(5,20).pre_value < 150) && (gsensor_2_times_flags == 0)
            rec_result = 1;
        else
            rec_result = 3;
        end
    end

end
