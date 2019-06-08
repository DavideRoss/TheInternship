using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public PlayerController Player;

    private GameObject[] _dossiers;
    private GameObject _currentDossier;

    void Start()
    {
        PickRandomDossier();
    }

    public void PickRandomDossier() {
        _dossiers = GameObject.FindGameObjectsWithTag("Dossier");
        Debug.Log(_dossiers.Length);
        _currentDossier = _dossiers[Random.Range(0, _dossiers.Length - 1)];
        _currentDossier.GetComponent<MeshRenderer>().material.color = Color.magenta;

        Debug.Log(_currentDossier);

        Player.PointerTarget = _currentDossier.transform;
    }
}
