using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoffeeMachineController : MonoBehaviour
{
    public float Cooldown = 3f;

    private PlayerController _player;
    private bool _active = true;

    private void Update() {
        if (!_player) return;

        if (_active && _player && Input.GetButtonDown("Fire1"))
        {
            _player.RefillCoffee(.3f);
            _active = false;
            GetComponent<MeshRenderer>().material.color = Color.black;
            StartCoroutine(StopCooldown());
        }
    }

    private void OnTriggerEnter(Collider other) {
        _player = other.GetComponent<PlayerController>();
        if (!_player) return;
        _player.ToggleCoffeeMachineIcon();
    }

    private void OnTriggerExit(Collider other) {
        _player.ToggleCoffeeMachineIcon();
        _player = null;
    }

    private IEnumerator StopCooldown() {
        yield return new WaitForSeconds(Cooldown);
        GetComponent<MeshRenderer>().material.color = Color.red;
        _active = true;
    }
}
