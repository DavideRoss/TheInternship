using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System.Linq;

public class GameController : MonoBehaviour
{
    public PlayerController Player;
    public DossierListController DossierList;
    public FillBar TimeBar;

    private GameObject[] _dossiers;
    private GameObject _currentDossier;

    private float _nextDossierDuration = 15f;
    private float _nextDossierTimeMult = .9f;
    private float _currentDossierTime = 0f;

    void Start()
    {
        PickRandomDossier();
    }

    private void Update() {
        _currentDossierTime += Time.deltaTime;
        TimeBar.CurrentValue = 1 - _currentDossierTime / _nextDossierDuration;

        if (_currentDossierTime >= _nextDossierDuration)
        {
            PickRandomDossier();
        }
    }

    public void PickRandomDossier() {
        // TODO: reactivate lose conditions
        //if (DossierList.DossierList.Count == 5)
        //{
        //    SceneManager.LoadScene("GameOverScene");
        //    return;
        //}

        _dossiers = GameObject.FindGameObjectsWithTag("Dossier").Where(d => !d.GetComponent<DossierController>().IsRequested).ToArray();
        _currentDossier = _dossiers[Random.Range(0, _dossiers.Length - 1)];
        DossierController currCtrl = _currentDossier.GetComponent<DossierController>();
        currCtrl.SetRequested();
        DossierList.AddDossier(currCtrl);

        Player.PointerTarget = _currentDossier.transform;

        _currentDossierTime = 0;
        _nextDossierDuration *= _nextDossierTimeMult;
        TimeBar.MaxTime = _nextDossierDuration;
    }
}
