module NikeMinus
  class Data
    # Demo IDs:
    # - Mine : 32034286
    # - Public : 417671841
    # - Not Public : 1709765374
    # - Not Valid : 42452

    URL         = "http://nikerunning.nike.com/nikeplus/v1/services"
    SUMMARYFILE = "/widget/get_public_run_list.jsp?userID="
    RUNFILE     = "/app/get_run.jsp?id="
    FULLSUMMARYPATH = [URL, SUMMARYFILE].join("")
    FULLRUNPATH = [URL, RUNFILE].join("")
    VALID_ID = %r{^[0-9]+$}

    def errors
      NikeMinus.errors
    end

    def valid_nike_id?(nike_id)
      @uid = nike_id
      return false unless valid_id? && valid_xml?
    end

    def valid_id?
      if (VALID_ID =~ @uid.to_s).nil?
        errors << "Invalid ID number"
        return false
      else
        return true
      end
    end

    def valid_xml?
      set_xml if @uid 
      status = @xml.xpath("//plusService//status").text
      if status.include?("failure") || status.empty?
        errors << @xml.xpath("//plusService//serviceException").text
        return false
      else
        return true
      end
    end

    def set_xml
      data = Curl::Easy.perform(FULLSUMMARYPATH+@uid.to_s).body_str rescue nil
      @xml = Nokogiri::XML(data)
    end

    def build_json
      xml_to_json(@xml) if valid_xml?
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
