using Microsoft.AspNetCore.Mvc;
using DataModule;

[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
    private readonly DataProvider _dataProvider;

    public DataController()
    {
        _dataProvider = new DataProvider();
    }

    [HttpGet]
    public IActionResult GetData()
    {
        return Ok(new { message = _dataProvider.GetData() });
    }
}
