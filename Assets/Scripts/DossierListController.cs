using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;

public class DossierListController : MonoBehaviour
{
    private Text _text;
    private List<DossierController> _dossiers = new List<DossierController>();
    public PlayerController Player;

    void Start()
    {
        _text = GetComponent<Text>();
    }

    public void AddDossier(DossierController dos) {
        _dossiers.Add(dos);
        Player.PointerTarget = _dossiers[0].transform;
        //RecalculateText();
    }

    public void DeleteDossier(DossierController dos) {
        _dossiers.Remove(dos);
        //RecalculateText();
    }

    void RecalculateText() {
        _text.text = string.Join("\n", _dossiers.Select(d => d.Zone));
    }

    public int Count() {
        return _dossiers.Count;
    }
}
