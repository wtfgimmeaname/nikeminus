module NikeMinus
  class Data
    URL         = "http://nikerunning.nike.com/nikeplus/v1/services"
    SUMMARYFILE = "/widget/get_public_run_list.jsp?userID="
    RUNFILE     = "/app/get_run.jsp?id="
    FULLSUMMARYPATH = [URL, SUMMARYFILE].join("")
    FULLRUNPATH = [URL, RUNFILE].join("")
    VALID_ID = %r{^[0-9]+$}

    def errors
      NikeMinus.errors
    end

    def valid_id?(uid)
      unless valid_id_string?(uid)
        errors << "Invalid ID number"
        return false
      end 
      set_xml(uid)
      valid_xml?
    end

    def valid_id_string?(uid)
      uid = uid.to_s if uid.is_a? Fixnum
      (uid =~ VALID_ID) ? true : false
    end

    def build_json
      xml_to_json(@xml) if valid_xml?
    end

    def set_xml(uid)
      data = Curl::Easy.perform(FULLSUMMARYPATH+uid.to_s).body_str rescue nil
      @xml = Nokogiri::XML(data)
    end

    def valid_xml?
      status = @xml.xpath("//plusService//status").text
      if status.include?("failure") || status.empty?
        errors << @xml.xpath("//plusService//serviceException").text
        return false
      else
        return true
      end
    end

    def xml_to_json(xml)
      builder = {:runs => {}}
      xml.xpath("//runList//run").each do |run|
        run_data = {}
        run.children().each {|kid| run_data[kid.name] = kid.text}
        
        builder[:runs][run.attribute('id').value] = {
          :workoutType => run.attribute('workoutType').value,
          :run_data    => run_data
        }
      end
      builder
    end

  end
end
