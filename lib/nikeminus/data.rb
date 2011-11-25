module NikeMinus
  class Data
    URL      = "http://nikerunning.nike.com"
    FILEPATH = "/nikeplus/v1/services/widget/get_public_run_list.jsp"
    URLPARAM = "?userID="
    FULLPATH = [URL, FILEPATH, URLPARAM].join("")
    VALID_ID = %r{^[0-9]+$}

    def self.valid_id?(uid)
      uid = uid.to_s if uid.is_a? Fixnum
      (uid =~ VALID_ID) ? true : false
    end

    def self.build_json(uid)
      xml = generate_xml(uid)
      xml_to_json(xml) if xml_valid?(xml)
    end

    def self.generate_xml(uid)
      data = Curl::Easy.perform(FULLPATH+uid.to_s).body_str rescue nil
      xml  = Nokogiri::XML(data)
    end

    def self.xml_valid?(xml)
      status = xml.xpath("//plusService//status").text
      !status.include?("failure") || !status.empty?
    end

    def self.xml_to_json(xml)
      builder = {:runs => {}}
      xml.xpath("//runList//run").each do |run|
        run_data = {}
        run.children().each {|kid| run_data[kid.name] = kid.text}
        
        builder[:runs][run.attribute('id').value] = {
          :workoutType => run.attribute('workoutType').value,
          :run_data    => run_data
        }
      end
      builder.to_json
    end

  end
end