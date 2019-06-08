using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FillBar : MonoBehaviour
{
    public Text DisplayText;
    public bool IsTimeBar = false;
    public float MaxTime;

    private Slider _slider;
    private float _currentVal;

    public float CurrentValue {
        get
        {
            return _currentVal;
        }

        set
        {
            _currentVal = Mathf.Clamp01(value);
            _slider.value = _currentVal;
            if (IsTimeBar)
            {
                DisplayText.text = Mathf.Round(_currentVal * MaxTime).ToString() + "s";
            } else
            {
                DisplayText.text = (_currentVal * 100).ToString("0.00") + "%";
            }
        }
    }

    void Start()
    {
        _slider = GetComponent<Slider>();
        CurrentValue = 1;
    }
}
