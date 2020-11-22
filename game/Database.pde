/* @author Antonio Bottelier
 * 
 * Base class to easily connect to your database.
 * Extend this to create a wrapper for a single table.
 */
public class Database
{
  private SQLConnection sqlConnection;
  private boolean useStaticConnection = false;

  public Database(String connectLink, boolean useStaticConnection, String username, String password)
  { 
    Properties properties = new Properties();
    if(username != null) properties.put("user", username);
    if(password != null) properties.put("password", password);

    this.useStaticConnection = useStaticConnection;
    if(useStaticConnection && GlobalDatabase.getConnection() == null)
    {
      GlobalDatabase.setConnection(new MySQLConnection(connectLink, properties));
    }
    else 
    {
      sqlConnection = new MySQLConnection(connectLink, properties);
    }
  }

  public Table runQuery(String query)
  {
    return getDatabase().runQuery(query);
  }

  public void updateQuery(String query)
  {
    getDatabase().updateQuery(query);
  }

  public SQLConnection getDatabase()
  {
    return (useStaticConnection ? GlobalDatabase.getConnection() : sqlConnection );
  }
}

public static class GlobalDatabase
{
  private static SQLConnection sqlConnection;

  public static void setConnection(SQLConnection con)
  {
    if(sqlConnection == null)
    {
      sqlConnection = con;
    }
    else
    {
      println("warning: the global database has already been set, not changing");
    }
  }

  public static SQLConnection getConnection()
  {
    return sqlConnection;
  }
}
