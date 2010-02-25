class Mysql::Result
  def each_utf8(&block)
    each_orig do |row|
      yield row.map { |c| String === c ? c.force_encoding("utf-8") : c }
    end
  end
  alias each_orig each
  alias each each_utf8

  def each_hash_utf8(&block)
    each_hash_orig do |row|
      row.each do |k, v|
        row[k] = String === v ? v.force_encoding("utf-8") : v
      end
      yield row
    end
  end
  alias each_hash_orig each_hash
  alias each_hash each_hash_utf8
end
